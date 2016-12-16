#!/bin/bash

# Set drush command for container.
drush="drush"

# Set build type.
dev_setup=false
if [[ $BUILD_ENV = "dev" ]]; then
  dev_setup=true
fi

# Start build.
if $dev_setup ; then
  # Dev build.
  echo "Building Local Development Enviroment."
  echo ""

  # Check/Add Drupal settings file.
  if [ ! -e "sites/default/settings.local.php" ]
  then
    echo "Copying over default datbase settings."
    cp -v "../scripts/settings.local.dist.php" "sites/default/settings.local.php"
    echo ""
  fi

  # Install production backup db.
  if [ -e "../production-db.sql" ] ; then

    # Drop current tables.
    echo "Dropping all tables."
    $drush sql-drop -y
    echo ""

    echo "Importing production backup database."
    if $drush sqlc < ../production-db.sql ; then
      echo "Database import successful."
      echo ""
    else
      echo "Database import failed."
      exit
    fi
  else
    echo "Can not find production-db.sql in project root."
    echo "Place a production backup named production-db.sql in project root."
    exit
  fi

  echo "Changeing Temporary Directory"
  $drush vset file_temporary_path /tmp
  echo ""
else
  # Production build.
  echo "Building Production Environment."
  echo ""
fi

# Rebuild registry.
echo "Registry rebuild"
$drush rr
echo ""

# Enable modules.
echo "Enabling modules."
if $dev_setup ; then
  # Enable for dev.
  echo "Enabling modules for development."
  $drush en $(cat ../scripts/drupal-modules-dev.txt | tr '\n' ' ') -y -v
  echo ""
fi

# Enable modules for all environments.
echo "Enabling modules for all environments."
$drush en $(cat ../scripts/drupal-modules.txt | tr '\n' ' ') -y -v
echo ""

# Disable / uninstall modules.
echo "Disabling modules."
if $dev_setup ; then
  # Disable for dev.
  echo "Disabling modules for development."
  $drush dis $(cat ../scripts/drupal-modules-dev-purge.txt | tr '\n' ' ') -y -v
else
  # Disable for production.
  echo "Disabling mmodules for all environments."
  $drush dis $(cat ../scripts/drupal-modules-purge.txt | tr '\n' ' ') -y -v
  echo ""

  # Uninstall for production.
  echo "Uninstalling modules we do not need on any environment.";
  $drush pm-uninstall $(cat ../scripts/drupal-modules-purge.txt | tr '\n' ' ') -y -v
fi
echo ""

# Run DB updates.
echo "Running any required database updates."
$drush updb -y
echo ""

# Clear the cache.
echo "Clearing cache."
$drush cc all
echo ""

# Revert features.
echo "Reverting all features."
$drush fra -y
echo ""

# Clear the cache.
echo "Clearing cache"
$drush cc all

# Additional settings for development only.
if $dev_setup ; then
  echo "Updating settings for development."
  echo ""

  # Check/Add user prometadmin.
  if $drush user-information prometadmin >/dev/null ; then
    echo "The user prometadmin already exist."
  else
    # Create a new user.
    echo "Creating user prometadmin."
    $drush user-create prometadmin --mail="test@test.com" --password="admin"
    echo "Adding user prometadmint to Administrator role."
    $drush user-add-role "Administrator" admin
  fi
  echo ""

  # Turn of css/js caching.
  echo "Disabling css and js caching.";
  $drush vset -y preprocess_css 0
  $drush vset -y preprocess_js 0
  echo ""

# else
  # Index the nodes in Solr (Uncomment next line when ready)
  # drush solr-index
fi

# Clear the cache.
echo "Clearing cache one last time."
$drush cc all
echo ""

echo "Build completed."
echo ""

# Create admin login url.
if $dev_setup ; then
  echo "Your Drupal uli is:"
  $drush uli admin
fi
