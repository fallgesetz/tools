/* configure test-rpc with my params */
var TestRPC = require ("ethereumjs-testrpc");
var util = require('util');


var inits = { 
		'accounts' : [
				{"balance": 0x1111111}
			]
		};

// ok, well figure out how to initiate testrpc server with custom settings
var server = TestRPC.server(inits);

server.listen(8545, function(err, blockchain) {
	console.log(util.inspect(blockchain, false, null));
});
