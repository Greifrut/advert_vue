<template>
  <v-dialog width="400" v-model="modal">
    <v-btn class="primary my-0 mx-2" slot="activator">Buy</v-btn>

    <v-card>
      <v-container>
        <v-layout>
          <v-flex xs12>
            <v-card-title>
              <h1 class="text--primary">Do you wan't to buy it?</h1>
            </v-card-title>
          </v-flex>
        </v-layout>
        <v-divider></v-divider>
        <v-layout>
          <v-flex xs12>
            <v-card-text>
              <v-text-field
              name="name"
              label="Your name"
              type="text"
              v-model="name"
              ></v-text-field>
              <v-text-field
              name="phone"
              label="Your phone"
              type="text"
              v-model="phone"
              ></v-text-field>
            </v-card-text>
          </v-flex>
        </v-layout>
        <v-layout>
          <v-flex xs12>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn flat @click="onCancel" >Close</v-btn>
              <v-btn class="success" @click="onSave">Buy it!</v-btn>
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
      name: '',
      phone: ''
    }
  },
  methods: {
    onCancel () {
      this.name = ''
      this.phone = ''
      this.modal = false
    },
    onSave () {
      if (this.name !== '' && this.phone !== '') {
        this.$http.secured.post('/orders', {order: {
          purchaser_name: this.name,
          purchaser_phone: this.phone,
          ad_id: this.ad.id,
          owner_id: this.ad.ownerId
        }})
        .then(response => {
          this.$store.commit('createOrder', {
            id: response.data.id,
            purchaserName: response.data.purchaser_name,
            purchaserPhone: response.data.purchaser_phone,
            adId: response.data.ad_id,
            done: response.data.done,
            ownerId: response.data.owner_id
          })
        })
        .catch(error => {
          this.$store.commit('setError', error.response.data)
        })
        this.modal = false
      }
    }
  }
}
</script>

