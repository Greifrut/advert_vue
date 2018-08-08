// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import store from './store'
import VueAxios from 'vue-axios'
import { secureAxiosInstance, plainAxiosInstance } from './backend/axios'

Vue.use(Vuetify)

Vue.config.productionTip = false
Vue.use(VueAxios, {
  secured: secureAxiosInstance,
  plain: plainAxiosInstance
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  secureAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
})
