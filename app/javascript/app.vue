<template>
  <div id="app">
    <table class="table">
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
          <td>{{repo.vote_count}}</td>
          <button type="submit" @click="handleClick(repo.name)" v-bind:disabled="hasVoted">Vote!</button>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";
// import Repo from "./components/Repo";
import { Auth_Token } from "../secrets.json";

export default {
  data: function () {
    return {
      info: {
        react: { vote_count: 0 },
        "angular.js": { vote_count: 0 },
        "ember.js": { vote_count: 0 },
        vue: { vote_count: 0 },
      },
      repos: [
        {
          owner: "facebook",
          repo: "react",
        },
        {
          owner: "angular",
          repo: "angular.js",
        },
        {
          owner: "emberjs",
          repo: "ember.js",
        },
        {
          owner: "vuejs",
          repo: "vue",
        },
      ],
      hasVoted: false
    };
  },
  methods: {
    fetchData: function () {
      this.repos.forEach((repo) =>
        axios
          .get(`https://api.github.com/repos/${repo.owner}/${repo.repo}`, {
            headers: {
              Authorization: `token ${Auth_Token}`, // allows for higher rate limit
            },
          })
          .then(
            (response) =>
              (this.info[`${repo.repo}`] = Object.assign(
                {
                  name: response.data.name,
                  forks: response.data.forks_count,
                  stars: response.data.stargazers_count,
                  watchers: response.data.subscribers_count,
                },
                this.info[`${repo.repo}`]
              ))
          )
      );
    },
    handleClick: function (name) {
      this.info[name]['vote_count'] += 1
      console.log(name);
      this.hasVoted = true
    },
  },
  mounted: function () {
    this.fetchData();
    setInterval(this.fetchData, 10000);
  },
};
</script>

<style scoped>

</style>
