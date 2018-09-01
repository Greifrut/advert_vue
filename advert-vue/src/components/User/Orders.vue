<template>
  <v-container>
    <v-layout row>
      <v-flex xs12 md6 sm12 offset-md3 v-if="myOrders.length !== 0">
        <h1 class="text--secondary mb-3">My Orders</h1>
        <v-layout
          my-4
          align-center
        >
        <strong class="mx-3 info--text text--darken-3">
          Remaining: {{ remainingOrders }}
        </strong>

        <v-divider vertical></v-divider>

        <strong class="mx-3 black--text">
          Completed: {{ completedOrders }}
        </strong>

        <v-spacer></v-spacer>

        <v-progress-circular
          :value="progress"
          color="green"
          class="mr-2"
        ></v-progress-circular>
      </v-layout>
        <v-list two-line subheader>
          <v-list-tile
            avatar
            v-for="order in myOrders"
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
                    @click="cancelOrder(order)"                
                    class="error ml-1"
                  >Delete</v-btn>
                </v-scroll-x-transition>
              </v-layout>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-flex>
    </v-layout>
    <v-layout row>
      <v-flex xs12 md6 sm12 offset-md3 v-if="userOrders.length !== 0">
        <h1 class="text--secondary mb-3">User orders</h1>
        <v-list two-line subheader>
          <v-list-tile
            avatar
            v-for="order in userOrders"
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
                  <v-btn
                  class="primary"
                  :to="'/ad/' + order.adId"
                >Open</v-btn>
                <v-btn
                  class="error ml-1"
                  @click="cancelOrder(order)"
                >Cancel</v-btn>
                <v-scroll-x-transition>
                  <v-btn
                    v-if="order.done"
                    @click="cancelOrder(order)"
                    class="success ml-1"
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
      if (this.myOrders.length === 0 || this.userOrders.length === 0) {
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
      myOrders () {
        return this.$store.getters.myOrders(this.currentUser)
      },
      currentUser () {
        return this.$store.getters.currentUser
      },
      userOrders () {
        return this.$store.getters.userOrders(this.currentUser)
      },
      completedOrders () {
        return this.$store.getters.completeOrders
      },
      remainingOrders () {
        return this.$store.state.orders.orders.length - this.completedOrders
      },
      progress () {
        return this.completedOrders / this.$store.state.orders.orders.length * 100
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
      },
      cancelOrder (order) {
        const index = this.$store.state.orders.orders.indexOf(order)
        this.$http.secured.delete('/orders/' + order.id)
          .then(response => {
            this.$store.commit('deleteOrder', index)
          })
      }
    }
  }
</script>