<template>
  <v-container fluid fill-height>
    <v-layout align-center justify-center>
      <v-flex xs12 sm8 md6>
        <v-card class="elevation-12">
          <v-toolbar dark color="primary">
            <v-toolbar-title>Registration form</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form v-model="valid" ref="form">
              <v-text-field
              prepend-icon="person"
              name="email"
              label="Email"
              type="email"
              v-model="email"
              :rules="emailRules"
              ></v-text-field>
              <v-text-field
               id="password"
               prepend-icon="lock"
               name="password"
               label="Password"
               type="password"
               v-model="password"
               :counter="6"
               :rules="passwordRules"
               ></v-text-field>
              <v-text-field
               id="password"
               prepend-icon="lock"
               name="confirm_password"
               label="Confirm Password"
               type="password"
               v-model="password_confirmation"
               :counter="6"
               :rules="confirmPasswordRules"
               ></v-text-field>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
            color="primary"
            @click="onSubmit"
            :disabled="!valid"
            >Create account</v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    data () {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        valid: false,
        emailRules: [
          v => !!v || 'E-mail is required',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail must be valid'
        ],
        passwordRules: [
          v => !!v || 'Password is required',
          v => (v && v.length >= 6) || 'Password must be equal or more than 6 characters'
        ],
        confirmPasswordRules: [
          v => !!v || 'Password is required',
          v => v === this.password || 'Passwords should be match'
        ]
      }
    },
    methods: {
      onSubmit () {
        if (this.$refs.form.validate()) {
          const user = {
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation
          }
          this.$http.plain.post('/signup', { user })
            .then(response => this.signupSuccessful(response))
            .catch(error => this.signupFailed(error))
        }
      },
      signupSuccessful (response) {
        if (!response.data.csrf) {
          this.signupFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        let user = response.data
        this.$store.commit('setUser', user)
        this.error = ''
        this.$router.replace('/')
      },
      signupFailed (error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something we wrong'
        delete localStorage.csrf
        delete localStorage.signedIn
      }
    }
  }
</script>