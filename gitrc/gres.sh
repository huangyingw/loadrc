#!/bin/zsh

conflictArr=($(git status | awk '/both .+:/{print $3}'))
#       git status | sed -e '/both modified:/!d;s/both modified://;s/^[\s\t]*//g;s/\ /\\ /g'
#       both modified:   Solutions/CohesitySecurity/Data Connectors/Helios2Sentinel/IncidentProducer/IncidentProducer.cs
#       both modified:   Solutions/CohesitySecurity/Data Connectors/Helios2Sentinel/IncidentProducer/local.settings.json
#       both added:      Solutions/CohesitySecurity/Data Connectors/Helios2Sentinel/azuredeploy.json
for conflict in "${conflictArr[@]}"
do
    git add $conflict
    git reset HEAD $conflict
done
