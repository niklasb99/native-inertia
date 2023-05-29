<script setup lang="ts">
import { router } from '@inertiajs/vue3';
import { watch } from 'vue';

let props = defineProps<{
	degree: number;
}>();


setInterval(function () {
	router.reload()
	router.get("/");
}, 1000);


document.addEventListener("visibilitychange", function () {
	if (document.visibilityState === "visible") {
		router.reload()
		router.get("/");
	}
});
</script>

<template>
	<main>
		<!-- <div><button @click="update">UPDATE!</button></div> -->
		<div>{{ props.degree }}</div>

	</main>
</template>


<!-- <script lang="ts">
export default {
  methods: {
    update() {
		alert("HI")
      router.reload();
      router.get("/");
    },
  },
};
</script> -->

<style>
main {
	font-family: Arial, Helvetica, sans-serif;
	position: relative;
}

body {
	margin: 0;
	background-color: #F2F2F7;
	padding-top: 6px;
	padding-left: 18px;
	padding-right: 18px;
}

button {
	all: unset;
	background-color: rgb(33, 149, 149);
	color: white;
	padding: 25px;
}
</style>