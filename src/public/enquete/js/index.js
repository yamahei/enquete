// See:
//   Getting Started@Vue Router
//   https://next.router.vuejs.org/guide/

(function(g){

	/**
	 * Init -> init.js
	 */

	/**
	* Components
	*/

	/**
	* Router
	*/
	//Page Components
	app.page = app.page || {};
	app.page.home = { template: '#PageOfHome' };
	app.page.about = { template: '#PageOfAbout' };
	//Routes
	app.routes.push({ path: '/', component: app.page.home });
	app.routes.push({ path: '/about', component: app.page.about });
	//Router
	app.router = VueRouter.createRouter({
		history: VueRouter.createWebHashHistory(),
		routes: app.routes,
	});

	/**
	* Start
	*/
	app.vue.use(app.router);
	app.vue.mount('#app');

})(this);
