import Vue from 'vue'
import Vuex from 'vuex'
import ads from './ads'
import user from './user'
import createPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

export const store = new Vuex.Store({
  modules: {
    ads, user
  },
  plugins: [createPersistedState({
    paths: ['user']
  })]
})
