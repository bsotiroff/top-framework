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
          <td>{{voteCounts[`${repo.name}`]}}</td>
          <button type="submit" @click="handleClick(repo.name)" v-bind:disabled="hasVoted">Vote!</button>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";
// import Repo from "./components/Repo";
import { Auth_Token } from "../../secrets.json";

export default {
  props:["voteCounts"],
  data: function () {
    return {
      info: {
        react: {votes: this.voteCounts['react']},
        "angular.js": {},
        "ember.js": {},
        vue: {},
      },
      votes: {
        react: 0,
        "angular.js": 0,
        "ember.js": 0,
        vue: 0,
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
        this.repos.forEach((repo) => {
          axios
            .get(`https://api.github.com/repos/${repo.owner}/${repo.repo}`, {
              headers: {
                Authorization: `token ${Auth_Token}`, // allows for higher rate limit
              },
            })
            .then(
              (response) => {
                this.info[`${repo.repo}`] = {
                  name: response.data.name,
                  forks: response.data.forks_count,
                  stars: response.data.stargazers_count,
                  watchers: response.data.subscribers_count,
                  // votes: this.voteCounts[`${repo.repo}`]
                  // votes: this.voteMapper(repo.repo)
                }
                console.log(this)
                // console.log(this.info[`${repo.repo}`][votes])
                // if (this.info[`${repo.repo}`][forks] !== response.data.forks_count) {
                //   this.info[`${repo.repo}`][forks] = response.data.forks_count
                // }
                // if (this.info[`${repo.repo}`][stars] !== response.data.stargazers_count) {
                //   this.info[`${repo.repo}`][stars] = response.data.stargazers_count
                // }
                // if (this.info[`${repo.repo}`][watchers] !== response.data.subscribers_count) {
                //   this.info[`${repo.repo}`][watchers] = response.data.subscribers_count
                // }
              }
            )
          }
        );
      },
      // voteMapper: function (repoName) {
      //   let repoToVotes = {
      //     react: this.reactVoteCount,
      //     "angular.js": this.angularVoteCount,
      //     "ember.js": this.emberVoteCount,
      //     vue: this.vueVoteCount,
      //   }
      //   console.log(repoToVotes)
      //   return repoToVotes[repoName]
      // },
      handleClick: function (name) {
        this.voteCounts[name] += 1
        console.log(name);
        this.hasVoted = true
      },
      initializeVotes: function () {
        this.votes = {
          react: this.voteCounts["react"],
          "angular.js": this.voteCounts["angular.js"],
          "ember.js": this.voteCounts["ember.js"],
          vue: this.voteCounts["vue"],
        }
        console.log('votes after', this.votes)
      }
    },
    // beforeUpdate: function () {
    //   this.initializeVotes();
    // },
    created: function () {
      this.votes = this.voteCounts
      console.log(this.voteCounts)
    },
    mounted: function () {
      this.fetchData();
      this.initializeVotes();
      setInterval(this.fetchData, 10000);
    },
};
</script>

<style scoped>

</style>
