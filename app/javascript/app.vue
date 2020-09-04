<template>
  <div id="app">
    <!-- <table class="table">
      <thead class="thead-dark">
        <tr>
          <th scope="col">Repository</th>
          <th scope="col">Watchers</th>
          <th scope="col">Stars</th>
          <th scope="col">Forks</th>
          <th scope="col">Votes</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="repo in info" :key="repo.name">
          <td scope="row">{{repo.name}}</td>
          <td>{{repo.watchers}}</td>
          <td>{{repo.stars}}</td>
          <td>{{repo.forks}}</td>
          <td>{{voteCounts[`${repo.name}`]}}</td>
          <button type="submit" @click="handleClick(repo.name)" v-bind:disabled="hasVoted">Vote!</button>
        </tr>
      </tbody>
    </table> -->
  </div>
</template>

<script>
import axios from "axios";

export default {
  props:["voteCounts"],
  data: function () {
    return {
      // info: []
    };
  },
  methods: {
      handleClick: function (name) {
        const request = new XMLHttpRequest();

        request.open('POST', '/repo_stats/vote', true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.send({name: name});
      },
      fetchData: function() {
        const request = new XMLHttpRequest();

        request.open('POST', '/repo_stats/fetch_api_data', true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.send();
        // $.post(`/repo_stats/fetch_api_data`);
      }
    },
    // also need some code to update props on 
    mounted: function () {
      this.fetchData();
      setInterval(this.fetchData, 10000);
    },
};
</script>

<style scoped>

</style>
