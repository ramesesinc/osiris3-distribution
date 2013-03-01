function RemoteProxy(c) {
	this.contextService = c;
	this.contextModule;
	
	var convertResult = function( result ) {
		if(result!=null) {
			if( result.trim().substring(0,1) == "["  || result.trim().substring(0,1) == "{"  ) {
				return $.parseJSON(result);
			}
			else {
				return eval(result);
			}
		}
		return null;
	}
	
	this.invoke = function( action, args, handler ) {
		var modname = this.contextModule? this.contextModule: window._MODULE_NAME; 
		modname = modname? modname+'/': ''
		
		var urlaction = "/js-invoke/" + modname + this.contextService+ "."+action;
		var err = null;	
		var data = []; 
		if( args ) { 
			data.push('args=' + encodeURIComponent($.toJSON( args )));
		}
		data = data.join('&');
		
		if(handler==null) {
			var result = $.ajax( {
				url:urlaction,
				type:"POST",
				error: function( xhr ) { 
					err = xhr.responseText; 
				},
				data: data,
				async : false }).responseText;

			if( err!=null ) {
				throw new Error(err);
			}
			return convertResult( result );
		}
		else {
			$.ajax( {
				url: urlaction,
				type: "POST",
				error: function( xhr ) { handler( null, new Error(xhr.responseText) ); },
				data: data,
				async: true,
				success: function( data) { 
					var r = convertResult(data);
					handler(r); 
				}
			});
		}
	}
};

var Service = new function() {
	this.debug = false;
	this.services = {}
	
	this.lookup = function(name, module) {
		if (this.debug == true && window.console) 
			window.console.log('Service_lookup: name='+name + ', module='+module); 
	
		if ( this.services[name]==null ) {
			var err = null;
			var modname = module? module: window._MODULE_NAME;
			modname = modname? modname+'/': '';
			if (this.debug == true && window.console) 
				window.console.log('Service_lookup: modname='+modname); 
			
			var urlaction =  "/js-proxy/"+ modname + name + ".js";
			if (this.debug == true && window.console) 
				window.console.log('Service_lookup: urlaction='+urlaction); 
			
			var result = $.ajax({
							url:urlaction,
							type:"GET",
							error: function( xhr ) { err = xhr.responseText },
							async : false 
						}).responseText;
			if ( err!=null ) throw new Error(err);

			if (this.debug == true && window.console) 
				window.console.log('Service_lookup: result='+result); 
			
			var func = eval( '(' + result + ')' );	
			var svc = new func();
			svc.proxy.contextModule = module; 
			this.services[name] = svc;
		}
		return this.services[name];
	} 
};