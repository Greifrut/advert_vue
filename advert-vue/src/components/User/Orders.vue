<template>
  <v-container>
    <v-layout row>
      <v-flex xs12 md6 sm12 offset-md3 v-if="orders.length !== 0">
        <h1 class="text--secondary mb-3">Orders</h1>
        <v-list two-line subheader>
          <v-list-tile
            avatar
            v-for="order in orders"
            :key="order.id"
          >
            <v-list-tile-action>
              <v-checkbox
                @change="markDone(order)"
                :input-value="order.done"
                color="success"
              ></v-checkbox>
            </v-list-tile-action>
            <v-list-tile-content>
              <v-list-tile-title> {{order.purchaserName}} </v-list-tile-title>
              <v-list-tile-sub-title> {{order.purchaserPhone}} </v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-layout row>  
                <v-scroll-x-transition>            
                  <v-btn
                  class="primary"
                  :to="'/ad/' + order.adId"
                >Open</v-btn>
                </v-scroll-x-transition>
                <v-scroll-x-transition>
                  <v-btn
                    v-if="order.done"
                    class="error ml-1"
                  >Delete</v-btn>
                </v-scroll-x-transition>
              </v-layout>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    created () {
      if (this.orders.length === 0) {
        this.$http.secured.get('/orders')
          .then(response => {
            Object.keys(response.data).forEach(key => {
              const order = response.data[key]
              this.$store.commit('createOrder', {
                id: order.id,
                purchaserName: order.purchaser_name,
                purchaserPhone: order.purchaser_phone,
                adId: order.ad_id,
                purchaserId: order.user_id,
                done: order.done,
                ownerId: order.owner_id
              })
            })
          })
      }
    },
    computed: {
      orders () {
        return this.$store.getters.orders
      },
      currentUser () {
        return this.$store.getters.currentUser
      }
    },
    methods: {
      markDone (order) {
        this.$http.secured.put('/orders/' + order.id, {order: {done: order.done}})
          .then(response => {
            this.$store.commit('updateOrder', {
              id: order.id,
              done: response.data.done
            })
          })
      }
    }
  }
</script>