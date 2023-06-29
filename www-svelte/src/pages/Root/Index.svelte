<script lang="ts">
	import { router } from "@inertiajs/svelte";
	import { writable } from "svelte/store";
  
	const start = writable(null);
  
	const countdown = writable(10);
  
	const count = writable(0);

	export let degree: string;
  
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
			//console.log(degree)
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
	<button on:click={handleClick}>Start</button>
	<h3>Anzahl Seitenaufrufe: {$count}</h3>
  </main>
  
  <style scoped>
	main {
	  font-family:system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	  text-align: left;
	  margin-left: 30px;
	}

	button {
		all: unset;
		padding: 15px;
		background-color: black;
		color: white;
		border-radius: 4px;
	}
  </style>
  