
export default {
  state: {
    currentUser: {},
    signedIn: false,
    csrf: null,
    error: null
  },
  mutations: {
    setCurrentUser (state, { currentUser, csrf }) {
      state.currentUser = currentUser
      state.signedIn = true
      state.csrf = csrf
    },
    unsetCurrentUser (state) {
      state.currentUser = {}
      state.signedIn = false
      state.csrf = null
    },
    refresh (state, csrf) {
      state.signedIn = true
      state.csrf = csrf
    },
    setError (state, error) {
      state.error = error
    },
    clearError (state) {
      state.error = null
    }
  },
  actions: {},
  getters: {
    isUserLoggedIn (state) {
      return state.signedIn
    },
    error (state) {
      return state.error
    }
  }
}
