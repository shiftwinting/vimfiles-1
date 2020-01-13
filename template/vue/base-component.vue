<template>
  <div>
    {{_cursor_}}
  </div>
</template>

<script>
export default {
  name: '{{_name_}}',
  props: {
    msg: {
      type: String,
      required: true,
    }
  },
}
</script>

<style scoped></style>
