(function(d){function b(k){var j=d('meta[name="csrf-token"]').attr("content");if(j){k.setRequestHeader("X-CSRF-Token",j)}}if("ajaxPrefilter" in d){d.ajaxPrefilter(function(j,l,k){b(k)})}else{d(document).ajaxSend(function(j,k){b(k)})}function c(m,j,l){var k=new d.Event(j);m.trigger(k,l);return k.result!==false}function i(m){var o,k,n,j=m.attr("data-type")||(d.ajaxSettings&&d.ajaxSettings.dataType);if(m.is("form")){o=m.attr("method");k=m.attr("action");n=m.serializeArray();var l=m.data("ujs:submit-button");if(l){n.push(l);m.data("ujs:submit-button",null)}}else{o=m.attr("data-method");k=m.attr("href");n=null}d.ajax({url:k,type:o||"GET",data:n,dataType:j,beforeSend:function(q,p){if(p.dataType===undefined){q.setRequestHeader("accept","*/*;q=0.5, "+p.accepts.script)}return c(m,"ajax:beforeSend",[q,p])},success:function(q,p,r){m.trigger("ajax:success",[q,p,r])},complete:function(q,p){m.trigger("ajax:complete",[q,p])},error:function(r,p,q){m.trigger("ajax:error",[r,p,q])}})}function f(n){var k=n.attr("href"),p=n.attr("data-method"),l=d("meta[name=csrf-token]").attr("content"),o=d("meta[name=csrf-param]").attr("content"),m=d('<form method="post" action="'+k+'"></form>'),j='<input name="_method" value="'+p+'" type="hidden" />';if(o!==undefined&&l!==undefined){j+='<input name="'+o+'" value="'+l+'" type="hidden" />'}m.hide().append(j).appendTo("body");m.submit()}function g(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.data("ujs:enable-with",k.val()).val(k.attr("data-disable-with")).attr("disabled","disabled")})}function a(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.val(k.data("ujs:enable-with")).removeAttr("disabled")})}function h(j){var k=j.attr("data-confirm");return !k||(c(j,"confirm")&&confirm(k))}function e(k){var j=false;k.find("input[name][required]").each(function(){if(!d(this).val()){j=true}});return j}d("a[data-confirm], a[data-method], a[data-remote]").live("click.rails",function(k){var j=d(this);if(!h(j)){return false}if(j.attr("data-remote")!=undefined){i(j);return false}else{if(j.attr("data-method")){f(j);return false}}});d("form").live("submit.rails",function(l){var j=d(this),k=j.attr("data-remote")!=undefined;if(!h(j)){return false}if(e(j)){return !k}if(k){i(j);return false}else{setTimeout(function(){g(j)},13)}});d("form input[type=submit], form button[type=submit], form button:not([type])").live("click.rails",function(){var k=d(this);if(!h(k)){return false}var j=k.attr("name"),l=j?{name:j,value:k.val()}:null;k.closest("form").data("ujs:submit-button",l)});d("form").live("ajax:beforeSend.rails",function(j){if(this==j.target){g(d(this))}});d("form").live("ajax:complete.rails",function(j){if(this==j.target){a(d(this))}})})(jQuery);(function(){$(document).ready(function(){var c,b,a;b=0;$("#previous a").click(function(){return a("right","left",-1)});$("#next a").click(function(){return a("left","right",1)});a=function(e,f,d){b+=d;$.ajax({url:"/increment",data:{weeks:b},success:function(h){var i,g;i=$(h)[0];g=$(h)[2];$("p#month").fadeOut("slow",function(){$("p#month").html(i);return $("p#month").fadeIn("slow")});return $("table").hide("slide",{direction:e},480,function(){$(this).replaceWith(g);return $("table").show("slide",{direction:f},300,function(){return $("#rando a").animate({opacity:0},"fast")})})}});return false};$("li a#sort_date").click(function(){return c("date")});$("li a#sort_name").click(function(){return c("name")});c=function(e){var f,d;d=location.pathname;f=d.split("/")[2];$.ajax({url:"/sort",data:{sortMethod:e,category:f},success:function(g){return $("ul#categories").fadeOut("slow",function(){$(this).html(g);return $(this).fadeIn("slow")})}});return false};return $("#rando a").click(function(){var e,d;e=this.getAttribute("data-message");d=Math.floor(Math.random()*e+1);return window.location="/events/"+d})})}).call(this);