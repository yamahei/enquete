(function(g){
    const enquetes = {
        template: '#PageOfList',
        common: g.app.common,
        data: function(){
            return {
                summaries: [],
            };
        },
        beforeRouteEnter: function(to, from, next){
            const summaries = g.app.debug.enquete_summaries;//TODO: load
            // next(error); // if error
            next(function(page){
                page.summaries.push(...summaries);
            });
        },
        computed: {
            has_enquetes: function(){ return this.summaries.length > 0; },
        },
        created: function(){// before "beforeRouteEnter"
            this.common = g.app.common;
        },
        beforeMount: function(){// before "beforeRouteEnter"
        },
        mounted: function(){// after "beforeRouteEnter"
        },
    };

    const app = g.app = g.app || {};
    app.page.enquetes = enquetes;
    app.routes.push({
        path: "/enquetes",
        component: app.page.enquetes,
    });

})(this);