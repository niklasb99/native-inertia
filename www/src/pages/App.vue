<script setup lang="ts">
import { router } from "@inertiajs/vue3";

// router.get("/");

// setInterval(function () {router.get("/");}, 1000);

function routing() {
	router.get("/");
}
</script>

<template>
	<header></header>

	<main>Redirect to Root...
		<button @click="routing">Let's go!</button>
	</main>
</template>

<style scoped></style>

