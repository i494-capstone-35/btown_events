(function(d){function b(k){var j=d('meta[name="csrf-token"]').attr("content");if(j){k.setRequestHeader("X-CSRF-Token",j)}}if("ajaxPrefilter" in d){d.ajaxPrefilter(function(j,l,k){b(k)})}else{d(document).ajaxSend(function(j,k){b(k)})}function c(m,j,l){var k=new d.Event(j);m.trigger(k,l);return k.result!==false}function i(m){var o,k,n,j=m.attr("data-type")||(d.ajaxSettings&&d.ajaxSettings.dataType);if(m.is("form")){o=m.attr("method");k=m.attr("action");n=m.serializeArray();var l=m.data("ujs:submit-button");if(l){n.push(l);m.data("ujs:submit-button",null)}}else{o=m.attr("data-method");k=m.attr("href");n=null}d.ajax({url:k,type:o||"GET",data:n,dataType:j,beforeSend:function(q,p){if(p.dataType===undefined){q.setRequestHeader("accept","*/*;q=0.5, "+p.accepts.script)}return c(m,"ajax:beforeSend",[q,p])},success:function(q,p,r){m.trigger("ajax:success",[q,p,r])},complete:function(q,p){m.trigger("ajax:complete",[q,p])},error:function(r,p,q){m.trigger("ajax:error",[r,p,q])}})}function f(n){var k=n.attr("href"),p=n.attr("data-method"),l=d("meta[name=csrf-token]").attr("content"),o=d("meta[name=csrf-param]").attr("content"),m=d('<form method="post" action="'+k+'"></form>'),j='<input name="_method" value="'+p+'" type="hidden" />';if(o!==undefined&&l!==undefined){j+='<input name="'+o+'" value="'+l+'" type="hidden" />'}m.hide().append(j).appendTo("body");m.submit()}function g(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.data("ujs:enable-with",k.val()).val(k.attr("data-disable-with")).attr("disabled","disabled")})}function a(j){j.find("input[data-disable-with]").each(function(){var k=d(this);k.val(k.data("ujs:enable-with")).removeAttr("disabled")})}function h(j){var k=j.attr("data-confirm");return !k||(c(j,"confirm")&&confirm(k))}function e(k){var j=false;k.find("input[name][required]").each(function(){if(!d(this).val()){j=true}});return j}d("a[data-confirm], a[data-method], a[data-remote]").live("click.rails",function(k){var j=d(this);if(!h(j)){return false}if(j.attr("data-remote")!=undefined){i(j);return false}else{if(j.attr("data-method")){f(j);return false}}});d("form").live("submit.rails",function(l){var j=d(this),k=j.attr("data-remote")!=undefined;if(!h(j)){return false}if(e(j)){return !k}if(k){i(j);return false}else{setTimeout(function(){g(j)},13)}});d("form input[type=submit], form button[type=submit], form button:not([type])").live("click.rails",function(){var k=d(this);if(!h(k)){return false}var j=k.attr("name"),l=j?{name:j,value:k.val()}:null;k.closest("form").data("ujs:submit-button",l)});d("form").live("ajax:beforeSend.rails",function(j){if(this==j.target){g(d(this))}});d("form").live("ajax:complete.rails",function(j){if(this==j.target){a(d(this))}})})(jQuery);(function(){$(document).ready(function(){var e,c,b,a,d;b=0;d=location.pathname.split("/")[1];c=function(){var f;f=$("#sitemap li").filter(function(){return $(this).text().toLowerCase().indexOf(d)!==-1});$(f).find("a").css({color:"white"});return $(f).css({color:"black",padding:"7px 13px","margin-right":"15px",background:"#CC0000","-webkit-border-radius":"8px","-moz-border-radius":"8px","border-radius":"8px"})};if(d!==""){c(d)}$("#previous a").click(function(){return a("right","left",-1)});$("#next a").click(function(){return a("left","right",1)});a=function(g,h,f){b+=f;$.ajax({url:"/increment",data:{weeks:b},success:function(j){var k,i;k=$(j)[0];i=$(j)[2];$("p#month").fadeOut("slow",function(){$("p#month").html(k).addClass("n_month");return $("p#month").fadeIn("slow")});return $("table").hide("slide",{direction:g},480,function(){$(this).replaceWith(i);return $("table").show("slide",{direction:h},300,function(){return $("#rando a").animate({opacity:0},"fast")})})}});return false};$("li a#sort_date").click(function(){return e("start_time")});$("li a#sort_name").click(function(){return e("name")});e=function(f){var g;d=location.pathname;g=d.split("/")[2];$.ajax({url:"/sort",data:{sortMethod:f,category:g}});({success:function(h){$("ul#categories").fadeOut("slow",function(){});$(this).html(h);return $(this).fadeIn("slow")}});return false};return $("#rando a").click(function(){var g,f;g=this.getAttribute("data-message");f=Math.floor(Math.random()*g+1);return window.location="/events/"+f})})}).call(this);