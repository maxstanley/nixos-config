{ config, pkgs, lib, ... }: {
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.max = { pkgs, ... }: {
    programs = {

       git = {
         userName = "Max Stanley";
         userEmail = "git@maxstanley.uk";
       };
           
     };
   };
}
