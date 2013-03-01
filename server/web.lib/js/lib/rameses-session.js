var Socket = new function() {

	this.session;
	
	function HttpSocket ( connection, channel ) {
		if (!channel) {
			alert('channel must be provided!');
			throw new Error('channel must be provided!');
		}	
		
		var self = this;
		var _connection = connection;
		var _channel = channel;
		var _token =  Math.floor(Math.random()*1000000001);
		
		this.handler;
		
		var poll = function() {
			$.ajax({ 
				url: "/osiris3/json-poll/clfc/"+_connection+"/"+_channel+"/t"+_token, 
				dataType: 'text',
				timeout: 20000,
				cache: false, 
				complete: function(o) {
					window.console.log("statusText=" + o.statusText + ", responseText=" + o.responseText);
					if (o.statusText == 'OK') {
						var result = $.parseJSON(o.responseText);
						if (self.handler) self.handler(result);
					} 
					poll();
				} 
			});
		}
		
		this.start = function(){
			poll();
		} 
	} 

	this.create = function( connection, channel ) {
		var socket = new HttpSocket( connection, channel );
		Socket.session = socket;
		return socket;
	}
} 

function Notifier( connection, channel ) {
	
	var self = this;
	var socket = Socket.create( connection, channel );
	
	this.handlers = {};
	
	this.connect = function() {
		
		socket.handler = function( data ) {
			for( var n in self.handlers ) {
				self.handlers[n]( data );
			}
		}
		
		socket.start();
	}
	
}
