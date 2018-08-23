<template>
  <v-dialog width="400" v-model="modal">
    <v-btn class="warning my-0 mx-2" flat slot="activator">Edit</v-btn>

    <v-card>
      <v-container>
        <v-layout>
          <v-flex xs12>
            <v-card-title>
              <h1 class="text--primary">Edit ad</h1>
            </v-card-title>
          </v-flex>
        </v-layout>
        <v-divider></v-divider>
        <v-layout>
          <v-flex xs12>
            <v-card-text>
              <v-text-field
              name="title"
              label="Title"
              type="text"
              v-model="editTitle"
              ></v-text-field>
              <v-textarea
              name="description"
              label="Description"
              type="text"
              multi-line
              v-model="editDescription"
              ></v-textarea>
            </v-card-text>
          </v-flex>
        </v-layout>
        <v-layout>
          <v-flex xs12>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn flat @click="onCancel" >Cancel</v-btn>
              <v-btn class="success" @click="onSave">Save</v-btn>
            </v-card-actions>
          </v-flex>
        </v-layout>
      </v-container>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: ['ad'],
  data () {
    return {
      modal: false,
      editTitle: this.ad.title,
      editDescription: this.ad.description
    }
  },
  methods: {
    onCancel () {
      this.editTitle = this.ad.title
      this.editDescription = this.ad.description
      this.modal = false
    },
    onSave () {
      if (this.editTitle !== '' && this.editDescription !== '') {
        this.$http.secured.put('/ads/' + this.ad.id, {ads: {
          title: this.editTitle,
          description: this.editDescription
        }})
        .then(response => {
          this.$store.commit('updateAd', {
            title: response.data.title,
            description: response.data.description,
            id: this.ad.id
          })
        })
        .catch(error => {
          this.$store.commit('setError', error.response.data.error)
        })
        this.modal = false
      }
    }
  }
}
</script>

