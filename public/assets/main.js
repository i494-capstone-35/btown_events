(function(d){function b(k){var j=d('meta[name="csrf-token"]').attr("content");if(j){k.setRequestHeader("X-CSRF-Token",j)}}if("ajaxPrefilter" in d){d.ajaxPrefilter(function(j,l,k){b(k)})}else{d(document).ajaxSend(function(j,k){b(k)})}function c(m,j,l){var k=new d.Event(j);m.trigger(k,l);return k.result!==false}function i(m){var o,k,n,j=m.attr("data-type")||(d.ajaxSettings&&d.ajaxSettings.dataType);if(m.is("form")){o=m.attr("method");k=m.attr("action");n=m.serializeArray();var l=m.data("ujs:submit-button");if(l){n.push(l);m.data("ujs:submit-button",null)}}else{o=m.attr("data-method");k=m.attr("href");n=null}d.ajax({url:k,type:o||"GET",data:n,dataType:j,beforeSend:function(q,p){if(p.dataType===undefined){q.setRequestHeader("accept","*/*;q=0.5, "+p.accepts.script)}return c(m,"ajax:beforeSend",[q,p])},success:function(q,p,r){m.trigger("ajax:success",[q,p,r])},complete:function(q,p){m.trigger("ajax:complete",[q,p])},error:function(r,p,q){m.trigger("ajax:error",[r,p,q])}})}function f(n){var k=n.attr("href"),p=n.attr("data-method"),l=d("meta[name=csrf-token]").attr("content"),o=d("meta[name=csrf-param]").attr("content"),m=d('<form method="post" action="'+k+'"></form>'),j='<input name="_method" value="'+p+'" type="hidden" />';if(o!==undefined&&l!==undefined){j+='<input name="'+o+'" value="'+l+'" type="hidden" />'}m.hide().append(j).appendTo("body");m.submit()}function g(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.data("ujs:enable-with",k.val()).val(k.attr("data-disable-with")).attr("disabled","disabled")})}function a(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.val(k.data("ujs:enable-with")).removeAttr("disabled")})}function h(j){var k=j.attr("data-confirm");return !k||(c(j,"confirm")&&confirm(k))}function e(k){var j=false;k.find("input[name][required]").each(function(){if(!d(this).val()){j=true}});return j}d("a[data-confirm], a[data-method], a[data-remote]").live("click.rails",function(k){var j=d(this);if(!h(j)){return false}if(j.attr("data-remote")!=undefined){i(j);return false}else{if(j.attr("data-method")){f(j);return false}}});d("form").live("submit.rails",function(l){var j=d(this),k=j.attr("data-remote")!=undefined;if(!h(j)){return false}if(e(j)){return !k}if(k){i(j);return false}else{setTimeout(function(){g(j)},13)}});d("form input[type=submit], form button[type=submit], form button:not([type])").live("click.rails",function(){var k=d(this);if(!h(k)){return false}var j=k.attr("name"),l=j?{name:j,value:k.val()}:null;k.closest("form").data("ujs:submit-button",l)});d("form").live("ajax:beforeSend.rails",function(j){if(this==j.target){g(d(this))}});d("form").live("ajax:complete.rails",function(j){if(this==j.target){a(d(this))}})})(jQuery);(function(){var a,c,b;b=window.location.pathname.split("/");c=a="";if(b.length===2){c=b[1]+"_images";a=b[1]==="places"?"images/logos/":"images/categories/";$.getJSON(c,function(f){var e,d;d=[];for(e in f){if(e<f.length){d.push((new Image()).src=a+f[e]+".png")}}return d})}}).call(this);(function(){$(document).ready(function(){var d,b,a,c;c=location.pathname.split("/");a=0;b=function(){var e;e=$("#sitemap li").filter(function(){return $(this).text().toLowerCase().indexOf(c)!==-1});$(e).find("a").css({color:"white"});return $(e).css({color:"black",background:"#CC0000",padding:"2px 10px","-webkit-border-radius":"8px","-moz-border-radius":"8px","border-radius":"8px"})};if(c!==""){b(c)}$("#prev_month a").click(function(){return d("right","left",-1,-1)});$("#next_month a").click(function(){return d("left","right",1,1)});$("#previous a").click(function(){return d("right","left",-1,0)});$("#next a").click(function(){return d("left","right",1,0)});return d=function(e,g,j,k){var f,i,h;if(k!==0){a=parseInt($("table")[0].getAttribute("data-message"));i=k}else{a=parseInt($("table")[0].getAttribute("data-message"))+j}if(k===0){$(".date").each(function(){switch(this.getAttribute("data-message")){case"next":if(j===1){return k=1}break;case"prev":if(j===-1){return k=-1}}})}if($("p#category").length===1){f=$("p#category")[0].innerHTML;h="/cat_increment"}else{h="increment"}$.ajax({url:h,data:{weeks:a,month:i,category:f},dataType:"html",success:function(l){if(k!==0){$("p#month").hide("slide",{direction:e},600,function(){$(this).replaceWith($(l).find("p#month")[0]);return $("p#month").show("slide",{direction:g},200)})}return $("table").hide("slide",{direction:e},480,function(){$(this).replaceWith($(l).find("table"));return $("table").show("slide",{direction:g},300)})}});return false}})}).call(this);