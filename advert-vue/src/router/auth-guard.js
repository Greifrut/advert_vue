import {store} from '../store/store'

export default function (to, from, next) {
  if (store.getters.isUserLoggedIn) {
    next()
  } else {
    next('/login?loginError=true')
  }
}
