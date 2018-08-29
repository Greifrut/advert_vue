class Order {
  constructor (id, ownerName, ownerPhone, adId, ownerId, done) {
    this.id = id
    this.ownerName = ownerName
    this.ownerPhone = ownerPhone
    this.adId = adId
    this.ownerId = ownerId
    this.done = done
  }
}

export default {
  state: {
    orders: []
  },
  mutations: {
    createOrder (state, {id, ownerName, ownerPhone, adId, ownerId, done}) {
      const allOrders = new Order(
        id,
        ownerName,
        ownerPhone,
        adId,
        ownerId,
        done
      )
      state.orders.push(allOrders)
    },
    deleteOrder (state, index) {
      state.orders.splice(index, 1)
    },
    updateOrder (state, {id, done}) {
      const ord = state.orders.find(o => {
        return o.id === id
      })
      ord.done = done
    }
  },
  actions: {},
  getters: {
    orders (state) {
      return state.orders
    }
  }
}
