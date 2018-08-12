<template>
  <v-app>
    <v-navigation-drawer app temporary v-model="drawer">
      <v-list>
        <v-list-tile
         v-for="link of links"
         :key="link.title"
         :to="link.url"
         >
          <v-list-tile-action>
            <v-icon>{{link.icon}}</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title v-text="link.title"></v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile
         @click="onLogout"
         >
          <v-list-tile-action>
            <v-icon>exit_to_app</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title v-text="'Logout'"></v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>
      </v-list>
    </v-navigation-drawer>

    <v-toolbar app dark color="primary">
      <v-toolbar-side-icon
       @click="drawer = !drawer"
       class="hidden-md-and-up"
       >
       </v-toolbar-side-icon>
      <v-toolbar-title>
        <router-link to="/" tag="span" class="pointer">Advert</router-link>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items class="hidden-sm-and-down">
        <v-btn
         v-for="link of links"
         :key="link.tile"
         :to="link.url"
         flat
        >
          <v-icon left>{{link.icon}}</v-icon>
          {{link.title}}
        </v-btn>
         <v-btn
         @click="onLogout"
         flat
        >
          <v-icon left>exit_to_app</v-icon>
          Logout
        </v-btn>
      </v-toolbar-items>
    </v-toolbar>

    <v-content>
      <router-view></router-view>
    </v-content>

  </v-app>
</template>

<script>
  export default {
    data () {
      return {
        drawer: false
      }
    },
    computed: {
      isUserLoggedIn () {
        return this.$store.getters.isUserLoggedIn
      },
      links () {
        if (this.isUserLoggedIn) {
          return [
            {title: 'Orders', icon: 'bookmark_border', url: '/orders'},
            {title: 'New ad', icon: 'note_add', url: '/new'},
            {title: 'My ads', icon: 'list', url: '/list'}
          ]
        }

        return [
          {title: 'Login', icon: 'lock', url: '/login'},
          {title: 'Registration', icon: 'face', url: '/registration'}
        ]
      }
    },
    methods: {
      onLogout () {
        this.$http.plain.delete('/signin')
          .then(response => {
            delete localStorage.csrf
            delete localStorage.signedIn
            delete localStorage.userId
            this.$router.replace('/')
          })
          .catch(error => (error.response && error.response.data && error.response.data.error))
      }
    }
  }
</script>

<style scoped>
  .pointer {
    cursor: pointer;
  }
</style>
