<template>
  <p v-if="message">{{ message }}</p>
</template>

<script setup>
import {computed} from 'vue'
const props = defineProps({
  error: {type: Array, required: true},
  errorKey: {type: String, required: true}
})

const message = computed(() => {
  const errors = props.error[props.errorKey]

  if (errors) {
    const key = props.errorKey.split('.').pop()
    return `${key} ${errors.join(', ')}`
  }
})

</script>

<style scoped lang="scss">
p {
  color: red;
  margin: 0;
  font-size: 1rem;
}
</style>