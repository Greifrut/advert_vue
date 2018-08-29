<template>
  <v-container>
    <v-layout row>
      <v-flex xs12>
        <v-card>
          <v-img
            :src="ad.imageSrc"
            height="300"
          >
          </v-img>
          <v-card-text>
            <h1 class="text--primary">{{ad.title}}</h1>
            <p>{{ad.description}}</p>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <app-edit-ad :ad="ad" ></app-edit-ad>
            <app-buy-modal :ad="ad" ></app-buy-modal>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  import EditAd from './EditAd'
  export default {
    props: ['id'],
    computed: {
      ad () {
        const id = parseInt(this.id)
        return this.$store.getters.adById(id)
      }
    },
    components: {
      appEditAd: EditAd
    }
  }
</script>