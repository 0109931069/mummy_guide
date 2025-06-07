<template>
  <!-- <router-view/> -->
  <div>
    <h4>Flutter To Do App</h4>
    <br />
    <div>
      <form @submit.prevent="onReset">
        <div>
          <input
            type="password"
            required
            placeholder="Password"
            v-model="password"
          />
        </div>

        <div>
          <input
            type="password"
            required
            placeholder="Confirm Password"
            v-model="confirmPassword"
          />
        </div>

        <hr />

        <button>Confirm</button>
      </form>
    </div>
  </div>
</template>

<script>
import { createClient } from "@supabase/supabase-js";

// Create a single supabase client for interacting with your database
const supabase = createClient(
  process.env.VUE_APP_SUPABASE_URL,
  process.env.VUE_APP_SUPABASE_KEY
);

export default {
  name: "ResetPage",
  data() {
    return {
      password: "",
      confirmPassword: "",
      access_token: "",
    };
  },
  async mounted() {
    // console.log(this.$route.query);

    supabase.auth.onAuthStateChange((event, session) => {
      console.log(event);

      if (event === "PASSWORD_RECOVERY") {
        console.log("PASSWORD_RECOVERY", session);
        this.access_token = session.access_token;
        // show screen to update user's password
        // showPasswordResetScreen(true);
      }
    });
  },
  methods: {
    async onReset() {
      if (this.password != this.confirmPassword) {
        alert("Passwords don't match!!");
        return;
      }

      // const res = await supabase.auth.exchangeCodeForSession(
      //   this.$route.query.code
      // );

      // console.log(res);

      // console.log(await supabase.auth.getUser());

      const res = await supabase.auth.updateUser({
        password: this.password,
      });

      // console.log(res);

      if (res.error === null) {
        alert("Success");

        window.close();
      } else {
        alert(res.error);
      }
    },
  },
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

nav {
  padding: 30px;
}

nav a {
  font-weight: bold;
  color: #2c3e50;
}

nav a.router-link-exact-active {
  color: #42b983;
}
</style>