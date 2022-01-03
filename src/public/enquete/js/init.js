// See:
//   Getting Started@Vue Router
//   https://next.router.vuejs.org/guide/

(function(g){

	/**
	 * Init
	 */
	const app = g.app = g.app || {};
	app.biz = new Biz();
	app.vue = Vue.createApp({biz: app.biz});
	app.routes = [];
	app.page = {};
	app.const = {
		status_names: {
			ready: "未公開",
			open: "公開中",
			close: "公開終了",
		},
	};
	app.common = {
		get_status_name: function(status){ return app.const.status_names[status] || ""; },
		is_status_ready: function(status){ return status == 'ready'; },
		is_status_open: function(status){ return status == 'open'; },
		is_status_close: function(status){ return status == 'close'; },
	};

})(this);
