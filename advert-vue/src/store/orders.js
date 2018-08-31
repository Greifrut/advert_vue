class Order {
  constructor (id, purchaserName, purchaserPhone, adId, purchaserId, done) {
    this.id = id
    this.purchaserName = purchaserName
    this.purchaserPhone = purchaserPhone
    this.adId = adId
    this.purchaserId = purchaserId
    this.done = done
  }
}

export default {
  state: {
    orders: []
  },
  mutations: {
    createOrder (state, {id, purchaserName, purchaserPhone, adId, purchaserId, done}) {
      const allOrders = new Order(
        id,
        purchaserName,
        purchaserPhone,
        adId,
        purchaserId,
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
