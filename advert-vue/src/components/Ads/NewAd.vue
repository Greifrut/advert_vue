<template>
  <v-container>
    <v-layout row>
      <v-flex xs12 sm6 offset-sm3>
        <h1 class="text--secondary mb-3">Create new ad</h1>
        <v-form v-model="valid" ref="form" validation class="mb-3">
          <v-text-field
            name="title"
            label="Ad title"
            type="text"
            v-model="title"
            required
            :rules="[ v => !!v || 'Title is required' ]"
          ></v-text-field>
          <v-textarea
            name="description"
            label="Ad description"
            type="text"
            v-model="description"
            :rules="[ v => !!v || 'Description is required' ]"
            ></v-textarea>
        </v-form>
        <v-layout class="mb-3" row>
          <v-flex xs12>
            <v-btn class="warning">
              Upload
              <v-icon right dark>cloud_upload</v-icon>
              </v-btn>
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs12>
            <img src="https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg" height="100">
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs12>
            <v-switch
              label="Add to promo?"
              v-model="promo"
              color="primary"
            ></v-switch>
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs12>
            <v-spacer></v-spacer>
            <v-btn
              :disabled="!valid"
              color="success"
              @click="createAd"
            >Create ad</v-btn>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    data () {
      return {
        title: '',
        description: '',
        promo: false,
        valid: false,

      }
    },
    methods: {
      createAd () {
        if (this.$refs.form.validate()) {
          this.$http.secured.post('/ads', { ads: {title: this.title, description: this.description, promo: this.promo, user_id: this.$store.state.user.currentUser.id}})
            .then(response => this.createSuccessful(response))
            .catch(error => this.errorCreate(error))
        }
      },
      createSuccessful (response) {
        if (!response.data.csrf) {
          this.errorCreate(response)
          return
        }
        this.$http.secured.get('/ads')
          .then(allResponse => {
            this.$store.commit('createAd', { title: allResponse.data.title,
                                             description: allResponse.data.description,
                                             promo: allResponse.data.promo,
                                             id: allResponse.data.id })
            this.error = ''
            this.$router.replace('/list')
          })
      },
      errorCreate (error) {
        this.error = (error.response && error.response.data && error.response.data.error)
        this.$store.commit('setError', error.response.data)
        this.$router.replace('/list')
      }
    }
  }
</script>