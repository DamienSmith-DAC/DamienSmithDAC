# Windows AD commands to create user, make member of group, and enable user for use
# This is only a sample  

dsadd user CN=dsaddtest,OU=Users,OU=PE,OU=DAC,DC=dac,DC=local -samid dsaddtest -pwd <PASSWORD>-fn dsaddtest -ln none -memberof CN=dace2_prod,OU=Groups,OU=PE,OU=DAC,DC=dac,DC=local -disabled no -upn dsaddtest@dac.local to github
dsmod user CN=dsaddtest,OU=Users,OU=PE,OU=DAC,DC=dac,DC=local -disabled no -mustchpwd yes
