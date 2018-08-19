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
            <v-btn class="warning" @click="trigerUpload">
              Upload
              <v-icon right dark>cloud_upload</v-icon>
              </v-btn>
              <input
                ref="fileInput"
                type="file"
                style="display:none"
                accept="image/*"
                @change="onFileChange"
              >
          </v-flex>
        </v-layout>
        <v-layout row>
          <v-flex xs12>
            <img :src="imageSrc" height="100" v-if="imageSrc">
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
              :disabled="!valid || !image"
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
        image: null,
        imageSrc: ''
      }
    },
    methods: {
      createAd () {
        if (this.$refs.form.validate() && this.image) {
          this.$http.secured.post('/ads', {ads:
          {
            title: this.title,
            description: this.description,
            promo: this.promo,
            user_id: this.$store.state.user.currentUser.id,
            image: this.imageSrc
          }})
            .then(response => this.createSuccessful(response))
            .catch(error => this.errorCreate(error))
        }
      },
      createSuccessful (response) {
        this.$store.commit('createAd', {
          title: response.data.title,
          description: response.data.description,
          userId: response.data.user_id,
          imageSrc: '',
          promo: response.data.promo,
          id: response.data.id
        })
        this.$router.replace('/')
      },
      errorCreate (error) {
        this.error = (error.response && error.response.data && error.response.data.error)
        this.$store.commit('setError', error.response.data)
        this.$router.replace('/list')
      },
      trigerUpload () {
        this.$refs.fileInput.click()
      },
      onFileChange (event) {
        const file = event.target.files[0]
        const reader = new FileReader()
        reader.onload = e => {
          this.imageSrc = reader.result
        }
        reader.readAsDataURL(file)
        this.image = file

      }
    }
  }
</script>