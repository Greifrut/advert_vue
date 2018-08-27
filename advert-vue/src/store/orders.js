class Order {
  constructor (id, ownerName, ownerPhone, adId, ownerId) {
    this.id = id
    this.ownerName = ownerName
    this.ownerPhone = ownerPhone
    this.adId = adId
    this.ownerId = ownerId
  }
}

export default {
  state: {
    orders: []
  },
  mutations: {
    createOrder (state, {id, ownerName, ownerPhone, adId, ownerId}) {
      const allOrders = new Order(
        id,
        ownerName,
        ownerPhone,
        adId,
        ownerId
      )
      state.orders.push(allOrders)
    }
  },
  actions: {},
  getters: {
    orders (state) {
      return state.orders
    }
  }
}
