export default {
  state: {
    ads: [
      {
        title: '',
        description: '',
        promo: false,
        imageSrc: 'https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg',
        id: ''
      }
    ]
  },
  mutations: {
    createAd (state, { title, description, promo, id }) {
      state.ads.title = title
      state.ads.description = description
      state.ads.promo = promo
      state.ads.id = id
    }
  },
  actions: {},
  getters: {
    ads (state) {
      return state.ads
    },
    promoAds (state) {
      return state.ads.filter(ad => {
        return ad.promo
      })
    },
    myAds (state) {
      return state.ads
    },
    adById (state) {
      return adId => {
        return state.ads.find(ad => ad.id === adId)
      }
    }
  }
}
