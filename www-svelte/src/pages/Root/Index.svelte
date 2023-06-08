<script lang="ts">
	import { router } from "@inertiajs/svelte";
	import { writable } from "svelte/store";
  
	const start = writable(null);
  
	const countdown = writable(10);
  
	const count = writable(0);
  
	const handleClick = () => {
	  countdown.set(10);
	  count.set(0);
	  start.set(Date.now().toString());
	  startCountdown();
	  router.get("/");
	};
  
	router.on("success", (event) => {
	  if ($start) {
		count.set($count + 1);
		if (Date.now() - parseInt($start) < 10000) {
		  router.get("/");
		}
	  }
	});
  
	let timer;
  
	function startCountdown() {
	  clearInterval(timer);
	  countdown.set(10);
	  timer = setInterval(() => {
		countdown.update((value) => {
		  if (value > 0) {
			return value - 1;
		  } else {
			clearInterval(timer);
			return 0;
		  }
		});
	  }, 1000);
	}
  </script>
  
  <header />
  
  <main>
	<h2>Countdown: {$countdown}</h2>
	<button on:click={handleClick}>Loop it!</button>
	<h2>Count: {$count}</h2>
  </main>
  
  <style scoped>
	main {
	  font-family:system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	  text-align: center;
	}

	button {
		all: unset;
		padding: 15px;
		background-color: black;
		color: white;
		border-radius: 4px;
	}
  </style>
  