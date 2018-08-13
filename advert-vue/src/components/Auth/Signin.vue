<template>
  <v-container fluid fill-height>
    <v-layout align-center justify-center>
      <v-flex xs12 sm8 md6>
        <v-card class="elevation-12">
          <v-toolbar dark color="primary">
            <v-toolbar-title>Login form</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form v-model="valid" ref="form" validation>
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
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
            color="primary"
            @click="onSubmit"
            :disabled="!valid"
            >Login</v-btn>
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
        valid: false,
        emailRules: [
          v => !!v || 'E-mail is required',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail must be valid'
        ],
        passwordRules: [
          v => !!v || 'Password is required',
          v => (v && v.length >= 6) || 'Password must be equal or more than 6 characters'
        ]
      }
    },
    methods: {
      onSubmit () {
        if (this.$refs.form.validate()) {
          const user = {
            email: this.email,
            password: this.password
          }
          this.$http.plain.post('/signin', user)
            .then(response => this.signinSuccessful(response))
            .catch(error => this.signinFailed(error))
        }
      },
      signinSuccessful (response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        this.$http.plain.get('/me')
          .then(meResponse => {
            this.$store.commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf })
            this.error = ''
            this.$roter.replace('/')
          })
      },
      signinFailed (error) {
        this.error = (error.response && error.response.data && error.response.data.error)
        this.$store.commit('unsetCurrentUser')
      }
    }
  }
</script>