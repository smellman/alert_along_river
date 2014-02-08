
# setup

    % sudo -u postgres createuser --interactive -P alert_along_river
    % sudo -u postgres createdb -O alert_along_river alert_along_river_development
	% sudo -u postgres createdb -O alert_along_river alert_along_river_test
	% sudo -u postgres createdb -O alert_along_river alert_along_river_production
	% sudo -u postgres psql alert_along_river_development -c "CREATE EXTENSION postgis;"
	% sudo -u postgres psql alert_along_river_development -c "CREATE EXTENSION postgis_topology;"
	% sudo -u postgres psql alert_along_river_test -c "CREATE EXTENSION postgis;"
	% sudo -u postgres psql alert_along_river_test -c "CREATE EXTENSION postgis_topology;"
	% sudo -u postgres psql alert_along_river_production -c "CREATE EXTENSION postgis;"
	% sudo -u postgres psql alert_along_river_production -c "CREATE EXTENSION postgis_topology;"
	% bundle install
