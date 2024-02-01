import {createInertiaApp} from "@inertiajs/vue3"
import {createApp, h} from "vue"
import * as Routes from "@/routes"

createInertiaApp({
  resolve: name => {
    const pages = import.meta.glob('../views/**/*.vue', {eager: true})
    const module = pages[`../views/${name}.vue`]
    if (!module) {
      throw new Error(`'${name}.vue' doesn't exist in app/frontend/views`)
    }
    return pages[`../views/${name}.vue`]
  },
  title: title => title.length > 0 ? `${title} - Robin`: 'Robin',
  setup({el, App, props, plugin}) {
    const vueApp = createApp({render: () => h(App, props)})
    vueApp.config.globalProperties.$routes = Routes
    vueApp.use(plugin).mount(el)

  }
})