export default {
  state: {
    user: {
      signedIn: false,
      id: '',
      email: ''
    }
  },
  mutations: {
    setUser (state, payload) {
      state.user = payload
    }
  },
  actions: {},
  getters: {
    user (state) {
      return state.user
    }
  }
}
