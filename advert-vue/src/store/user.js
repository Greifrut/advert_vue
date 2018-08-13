import createPersistedState from 'vuex-persistedstate'

export default {
  state: {
    currentUser: {},
    signedIn: false,
    csrf: null
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
    }
  },
  actions: {},
  getters: {
    isUserLoggedIn (state) {
      return state.signedIn
    }
  },
  plugins: [createPersistedState()]
}
