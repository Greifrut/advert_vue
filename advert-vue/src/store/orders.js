class Order {
  constructor (id, purchaserName, purchaserPhone, adId, purchaserId, done, ownerId) {
    this.id = id
    this.purchaserName = purchaserName
    this.purchaserPhone = purchaserPhone
    this.adId = adId
    this.purchaserId = purchaserId
    this.done = done
    this.ownerId = ownerId
  }
}

export default {
  state: {
    orders: []
  },
  mutations: {
    createOrder (state, {id, purchaserName, purchaserPhone, adId, purchaserId, done, ownerId}) {
      const allOrders = new Order(
        id,
        purchaserName,
        purchaserPhone,
        adId,
        purchaserId,
        done,
        ownerId
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
    orders: (state) => (id) => {
      return state.orders.filter(o => o.purchaserId === id)
    }
  }
}
