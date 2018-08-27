class Order {
  constructor (ownerName, ownerPhone, adId, ownerId) {
    this.ownerName = ownerName
    this.ownerPhone = ownerPhone
    this.adId = adId
    this.ownerId = ownerId
  }
}

export default {
  store: {
    orders: []
  },
  mutations: {
    createOrder (state, {ownerName, ownerPhone, adId, ownerId}) {
      const allOrders = new Order(
        ownerName,
        ownerPhone,
        adId,
        ownerId
      )
      state.push(allOrders)
    }
  },
  actions: {},
  getters: {}
}