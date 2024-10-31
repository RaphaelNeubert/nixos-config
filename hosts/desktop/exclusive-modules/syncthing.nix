{config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [ 
		syncthing
	];
	services.syncthing = {
		enable = true;
		dataDir = "/home/raphael";  # default sync dir
			openDefaultPorts = true;
		configDir = "/home/raphael/.config/syncthing";
		user = "raphael";
		group = "users";
		guiAddress = "0.0.0.0:8384";
		declarative = {
			overrideDevices = true;
			overrideFolders = true;
			#devices = {
			#	"laptop" = { id = "REALLY-LONG-LAPTOP-SYNCTHING-KEY-HERE"; };
			#};
			#folders = {
			#	"tu" = { 
			#		path = "/home/raphael/tu"; 
			#		devices = [ "laptop" ]; 
			#		versioning = { 
			#			type = "staggered"; 
			#			params = { 
			#				cleanInterval = "3600"; 
			#				maxAge = "2592000";
			#			}; 
			#		}; 
			#	};
			#};

		};
	};
}
