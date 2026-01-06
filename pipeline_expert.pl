% ============================================================================
% SYSTÈME EXPERT : DIAGNOSTIC ET OPTIMISATION DES PIPELINES DE DONNÉES
% ============================================================================
% Auteur: Maryem EL YAZGHI
% Module: Ingénierie de la Connaissance - GINF3
% Description: Système à base de connaissances pour diagnostiquer et optimiser
%              les pipelines de données ETL/ELT
% ============================================================================

:- dynamic symptom/1.
:- dynamic pipeline_characteristic/2.
:- dynamic user_response/2.
:- encoding(utf8).
:- set_prolog_flag(encoding, utf8).

% ============================================================================
% BASE DE CONNAISSANCES - PROBLÈMES ET SYMPTÔMES
% ============================================================================

% Définition des problèmes principaux
problem(schema_drift).
problem(performance_bottleneck).
problem(data_quality_issue).
problem(resource_exhaustion).
problem(job_failure).
problem(network_connectivity).
problem(permission_error).
problem(duplicate_data).
problem(missing_data).
problem(transformation_error).

% Description des problèmes
problem_description(schema_drift, 
    'Changement de schéma non géré - colonnes ajoutées, supprimées ou renommées').
problem_description(performance_bottleneck, 
    'Goulot d\'étranglement - pipeline lent ou inefficace').
problem_description(data_quality_issue, 
    'Problème de qualité des données - valeurs incorrectes ou manquantes').
problem_description(resource_exhaustion, 
    'Épuisement des ressources - mémoire, CPU ou stockage insuffisants').
problem_description(job_failure, 
    'Échec d\'exécution - tâches qui échouent de manière répétée').
problem_description(network_connectivity, 
    'Problème de connectivité réseau - timeout ou connexion perdue').
problem_description(permission_error, 
    'Erreur de permissions - accès refusé aux ressources').
problem_description(duplicate_data, 
    'Données dupliquées - enregistrements en double dans le pipeline').
problem_description(missing_data, 
    'Données manquantes - source de données non disponible').
problem_description(transformation_error, 
    'Erreur de transformation - échec lors de la manipulation des données').

% ============================================================================
% RÈGLES DE DIAGNOSTIC - SCHÉMA
% ============================================================================

% Règle 1: Détection du schema drift
diagnose(schema_drift) :-
    symptom(pipeline_fails_suddenly),
    symptom(column_not_found_error),
    pipeline_characteristic(recently_changed, yes),
    \+ symptom(network_timeout).

diagnose(schema_drift) :-
    symptom(data_type_mismatch),
    symptom(parsing_error),
    pipeline_characteristic(source_updated, yes).

diagnose(schema_drift) :-
    symptom(unexpected_null_values),
    symptom(missing_columns),
    pipeline_characteristic(working_previously, yes).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - PERFORMANCE
% ============================================================================

% Règle 2: Détection des problèmes de performance
diagnose(performance_bottleneck) :-
    symptom(slow_execution),
    symptom(high_processing_time),
    \+ symptom(network_timeout),
    pipeline_characteristic(data_volume, high).

diagnose(performance_bottleneck) :-
    symptom(slow_execution),
    symptom(sequential_processing),
    pipeline_characteristic(parallelizable, yes).

diagnose(performance_bottleneck) :-
    symptom(multiple_intermediate_reads),
    symptom(inefficient_queries),
    pipeline_characteristic(architecture, monolithic).

diagnose(performance_bottleneck) :-
    symptom(slow_execution),
    symptom(disk_io_heavy),
    pipeline_characteristic(in_memory_possible, yes).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - QUALITÉ DES DONNÉES
% ============================================================================

% Règle 3: Problèmes de qualité des données
diagnose(data_quality_issue) :-
    symptom(incorrect_values),
    symptom(data_validation_fails),
    pipeline_characteristic(validation_enabled, no).

diagnose(data_quality_issue) :-
    symptom(inconsistent_formats),
    symptom(data_corruption),
    pipeline_characteristic(source_reliability, low).

diagnose(data_quality_issue) :-
    symptom(outlier_values),
    symptom(statistical_anomalies),
    pipeline_characteristic(monitoring_enabled, no).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - RESSOURCES
% ============================================================================

% Règle 4: Épuisement des ressources
diagnose(resource_exhaustion) :-
    symptom(out_of_memory_error),
    symptom(pipeline_crashes),
    pipeline_characteristic(memory_intensive, yes).

diagnose(resource_exhaustion) :-
    symptom(high_cpu_usage),
    symptom(slow_execution),
    pipeline_characteristic(optimization_level, low).

diagnose(resource_exhaustion) :-
    symptom(disk_space_full),
    symptom(cannot_write_output),
    pipeline_characteristic(cleanup_policy, none).

diagnose(resource_exhaustion) :-
    symptom(connection_pool_exhausted),
    symptom(timeout_errors),
    pipeline_characteristic(concurrent_connections, high).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - ÉCHECS D'EXÉCUTION
% ============================================================================

% Règle 5: Échecs d'exécution
diagnose(job_failure) :-
    symptom(task_fails_repeatedly),
    symptom(error_in_logs),
    pipeline_characteristic(retry_mechanism, no).

diagnose(job_failure) :-
    symptom(dependency_not_met),
    symptom(waiting_for_runner),
    pipeline_characteristic(orchestration, misconfigured).

diagnose(job_failure) :-
    symptom(code_exception),
    symptom(unhandled_error),
    pipeline_characteristic(error_handling, inadequate).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - RÉSEAU
% ============================================================================

% Règle 6: Problèmes réseau
diagnose(network_connectivity) :-
    symptom(connection_timeout),
    symptom(intermittent_failures),
    pipeline_characteristic(network_dependent, yes).

diagnose(network_connectivity) :-
    symptom(api_unreachable),
    symptom(http_error_codes),
    pipeline_characteristic(external_source, yes).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - PERMISSIONS
% ============================================================================

% Règle 7: Erreurs de permissions
diagnose(permission_error) :-
    symptom(access_denied),
    symptom(authentication_failed),
    pipeline_characteristic(credentials_updated, recently).

diagnose(permission_error) :-
    symptom(cannot_read_source),
    symptom(permission_denied_error),
    pipeline_characteristic(security_policy, strict).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - DUPLICATION
% ============================================================================

% Règle 8: Données dupliquées
diagnose(duplicate_data) :-
    symptom(repeated_records),
    symptom(duplicate_keys),
    pipeline_characteristic(deduplication, disabled).

diagnose(duplicate_data) :-
    symptom(inflated_record_count),
    symptom(processing_same_batch_twice),
    pipeline_characteristic(idempotency, no).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - DONNÉES MANQUANTES
% ============================================================================

% Règle 9: Données manquantes
diagnose(missing_data) :-
    symptom(empty_result_set),
    symptom(source_unavailable),
    pipeline_characteristic(dependency_check, no).

diagnose(missing_data) :-
    symptom(incomplete_data),
    symptom(partner_missed_delivery),
    pipeline_characteristic(external_dependency, yes).

% ============================================================================
% RÈGLES DE DIAGNOSTIC - TRANSFORMATION
% ============================================================================

% Règle 10: Erreurs de transformation
diagnose(transformation_error) :-
    symptom(calculation_incorrect),
    symptom(aggregation_fails),
    pipeline_characteristic(logic_complex, yes).

diagnose(transformation_error) :-
    symptom(join_produces_wrong_results),
    symptom(key_mismatch),
    pipeline_characteristic(data_model, unclear).

% ============================================================================
% BASE DE CONNAISSANCES - SOLUTIONS
% ============================================================================

% Solutions pour Schema Drift
solution(schema_drift, 
    'Implémenter une validation de schéma automatique',
    'Utiliser des outils comme Great Expectations ou Apache Griffin',
    high).

solution(schema_drift,
    'Mettre en place des alertes de changement de schéma',
    'Configurer la détection proactive avec des outils d\'observabilité',
    high).

solution(schema_drift,
    'Créer une couche d\'abstraction pour gérer les changements',
    'Utiliser des adaptateurs de schéma ou schema evolution',
    medium).

solution(schema_drift,
    'Établir un contrat de données avec les fournisseurs',
    'Documentation formelle des structures de données attendues',
    medium).

% Solutions pour Performance
solution(performance_bottleneck,
    'Implémenter le traitement parallèle',
    'Diviser les tâches en chunks avec Spark, Kafka Streams ou Hadoop',
    high).

solution(performance_bottleneck,
    'Optimiser les formats de stockage',
    'Utiliser Parquet, ORC ou Delta Lake pour un accès plus rapide',
    high).

solution(performance_bottleneck,
    'Activer le traitement en mémoire',
    'Utiliser Redis, Memcached ou Spark in-memory processing',
    medium).

solution(performance_bottleneck,
    'Optimiser les requêtes de base de données',
    'Ajouter des index, partitionner les tables, optimiser les jointures',
    high).

solution(performance_bottleneck,
    'Diviser les pipelines monolithiques',
    'Créer des micro-pipelines avec des responsabilités claires',
    medium).

solution(performance_bottleneck,
    'Mettre en place l\'auto-scaling',
    'Configurer l\'échelle automatique des ressources cloud',
    medium).

% Solutions pour Qualité des Données
solution(data_quality_issue,
    'Implémenter des validations de données',
    'Ajouter des checks de qualité à chaque étape du pipeline',
    high).

solution(data_quality_issue,
    'Mettre en place un monitoring de qualité',
    'Utiliser des outils comme Monte Carlo, Databand ou dbt tests',
    high).

solution(data_quality_issue,
    'Créer des règles de nettoyage de données',
    'Standardiser les formats, gérer les valeurs nulles, détecter les outliers',
    medium).

solution(data_quality_issue,
    'Établir des SLA de qualité des données',
    'Définir des métriques de qualité et des seuils d\'alerte',
    medium).

% Solutions pour Ressources
solution(resource_exhaustion,
    'Optimiser l\'utilisation de la mémoire',
    'Utiliser le streaming, le batching et le garbage collection',
    high).

solution(resource_exhaustion,
    'Implémenter le nettoyage automatique',
    'Configurer TTL et politiques de rétention des données',
    high).

solution(resource_exhaustion,
    'Utiliser des instances spot/préemptibles',
    'Réduire les coûts pour les tâches non critiques',
    medium).

solution(resource_exhaustion,
    'Monitorer l\'utilisation des ressources',
    'Mettre en place CloudWatch, Prometheus ou Grafana',
    high).

solution(resource_exhaustion,
    'Dimensionner correctement les ressources',
    'Analyser les patterns d\'utilisation et ajuster la capacité',
    medium).

% Solutions pour Échecs d'Exécution
solution(job_failure,
    'Implémenter un mécanisme de retry',
    'Ajouter exponential backoff et circuit breakers',
    high).

solution(job_failure,
    'Améliorer la gestion des erreurs',
    'Capturer et loguer toutes les exceptions avec contexte',
    high).

solution(job_failure,
    'Configurer correctement l\'orchestration',
    'Vérifier les dépendances et la configuration Airflow/Dagster',
    high).

solution(job_failure,
    'Ajouter des health checks',
    'Vérifier l\'état des dépendances avant l\'exécution',
    medium).

% Solutions pour Réseau
solution(network_connectivity,
    'Implémenter des retry avec backoff',
    'Gérer les erreurs transitoires réseau automatiquement',
    high).

solution(network_connectivity,
    'Utiliser des connexions persistantes',
    'Connection pooling et keep-alive pour réduire les overhead',
    medium).

solution(network_connectivity,
    'Ajouter un monitoring réseau',
    'Surveiller latence, packet loss et disponibilité',
    medium).

solution(network_connectivity,
    'Implémenter un cache local',
    'Réduire la dépendance aux sources externes',
    medium).

% Solutions pour Permissions
solution(permission_error,
    'Vérifier et mettre à jour les credentials',
    'S\'assurer que les tokens et clés sont valides et non expirés',
    high).

solution(permission_error,
    'Appliquer le principe du moindre privilège',
    'Accorder uniquement les permissions nécessaires (IAM roles)',
    high).

solution(permission_error,
    'Automatiser la rotation des secrets',
    'Utiliser AWS Secrets Manager, Azure Key Vault ou HashiCorp Vault',
    medium).

solution(permission_error,
    'Documenter les permissions requises',
    'Maintenir une documentation claire des accès nécessaires',
    low).

% Solutions pour Duplication
solution(duplicate_data,
    'Implémenter la déduplication',
    'Utiliser des clés uniques et des outils comme Lake Formation FindMatches',
    high).

solution(duplicate_data,
    'Rendre le pipeline idempotent',
    'Assurer qu\'une exécution multiple produit le même résultat',
    high).

solution(duplicate_data,
    'Utiliser des identifiants uniques',
    'Implémenter UUID ou des clés composites pour chaque record',
    medium).

solution(duplicate_data,
    'Ajouter des contraintes d\'unicité',
    'Configurer des contraintes au niveau de la base de données',
    medium).

% Solutions pour Données Manquantes
solution(missing_data,
    'Implémenter des vérifications de dépendances',
    'Vérifier la disponibilité des sources avant exécution',
    high).

solution(missing_data,
    'Ajouter des alertes de disponibilité',
    'Notifier quand les sources ne livrent pas les données',
    high).

solution(missing_data,
    'Mettre en place des SLA avec les fournisseurs',
    'Établir des accords sur la disponibilité des données',
    medium).

solution(missing_data,
    'Implémenter un fallback mechanism',
    'Utiliser des données historiques ou des valeurs par défaut',
    medium).

% Solutions pour Transformation
solution(transformation_error,
    'Améliorer les tests unitaires',
    'Tester chaque transformation avec des cas limites',
    high).

solution(transformation_error,
    'Simplifier la logique de transformation',
    'Diviser les transformations complexes en étapes simples',
    medium).

solution(transformation_error,
    'Valider les résultats de transformation',
    'Ajouter des assertions et des checks de sanité',
    high).

solution(transformation_error,
    'Documenter la logique métier',
    'Clarifier les règles de transformation et les attentes',
    medium).

% ============================================================================
% RÈGLES D'OPTIMISATION PRÉVENTIVE
% ============================================================================

optimization_recommendation(parallel_processing) :-
    pipeline_characteristic(data_volume, high),
    pipeline_characteristic(parallelizable, yes),
    \+ pipeline_characteristic(parallel_enabled, yes).

optimization_recommendation(in_memory_processing) :-
    pipeline_characteristic(real_time, yes),
    pipeline_characteristic(memory_available, sufficient),
    \+ pipeline_characteristic(in_memory_enabled, yes).

optimization_recommendation(efficient_storage_format) :-
    pipeline_characteristic(query_intensive, yes),
    pipeline_characteristic(storage_format, csv),
    pipeline_characteristic(data_volume, high).

optimization_recommendation(monitoring_setup) :-
    pipeline_characteristic(production, yes),
    pipeline_characteristic(monitoring_enabled, no).

optimization_recommendation(auto_scaling) :-
    pipeline_characteristic(variable_load, yes),
    pipeline_characteristic(cloud_based, yes),
    \+ pipeline_characteristic(auto_scaling_enabled, yes).

optimization_recommendation(data_validation) :-
    pipeline_characteristic(production, yes),
    pipeline_characteristic(validation_enabled, no).

optimization_recommendation(schema_versioning) :-
    pipeline_characteristic(external_sources, yes),
    pipeline_characteristic(schema_management, no).

optimization_recommendation(cost_optimization) :-
    pipeline_characteristic(cloud_costs, high),
    pipeline_characteristic(optimization_level, low).

% Descriptions des optimisations
optimization_description(parallel_processing,
    'Implémenter le traitement parallèle pour améliorer les performances',
    'Diviser les données en chunks et les traiter simultanément',
    'Spark, Kafka Streams, Hadoop MapReduce').

optimization_description(in_memory_processing,
    'Utiliser le traitement en mémoire pour réduire les I/O',
    'Stocker les données en RAM pour un accès plus rapide',
    'Redis, Memcached, Spark In-Memory').

optimization_description(efficient_storage_format,
    'Adopter des formats de stockage optimisés',
    'Utiliser des formats colonnaires pour de meilleures performances',
    'Apache Parquet, ORC, Delta Lake').

optimization_description(monitoring_setup,
    'Mettre en place un système de monitoring complet',
    'Surveiller les performances, erreurs et qualité des données',
    'Datadog, Prometheus, Grafana, Monte Carlo Data').

optimization_description(auto_scaling,
    'Configurer l\'auto-scaling des ressources',
    'Ajuster automatiquement la capacité selon la charge',
    'AWS Auto Scaling, GCP Autoscaler, Azure VMSS').

optimization_description(data_validation,
    'Implémenter des validations de données robustes',
    'Vérifier la qualité et l\'intégrité à chaque étape',
    'Great Expectations, dbt tests, Apache Griffin').

optimization_description(schema_versioning,
    'Mettre en place la gestion de versions de schéma',
    'Gérer les évolutions de schéma de manière contrôlée',
    'Schema Registry, Delta Lake, Avro').

optimization_description(cost_optimization,
    'Optimiser les coûts d\'infrastructure cloud',
    'Réduire l\'utilisation des ressources sans compromettre les performances',
    'Spot instances, Reserved instances, Resource tagging').

% ============================================================================
% MÉTRIQUES ET SEUILS
% ============================================================================

% Définition des métriques importantes
metric(execution_time, seconds).
metric(data_throughput, 'records/second').
metric(error_rate, percentage).
metric(resource_utilization, percentage).
metric(data_quality_score, percentage).
metric(cost_per_run, dollars).

% Seuils critiques
critical_threshold(execution_time, 3600).  % 1 heure
critical_threshold(error_rate, 5).         % 5%
critical_threshold(resource_utilization, 90). % 90%
critical_threshold(data_quality_score, 95).   % Minimum 95%

% Seuils d'alerte
warning_threshold(execution_time, 1800).   % 30 minutes
warning_threshold(error_rate, 2).          % 2%
warning_threshold(resource_utilization, 75). % 75%
warning_threshold(data_quality_score, 98).   % Minimum 98%

% ============================================================================
% RÈGLES D'ÉVALUATION DES MÉTRIQUES
% ============================================================================

metric_status(Metric, Value, critical) :-
    critical_threshold(Metric, Threshold),
    (Metric = data_quality_score -> Value < Threshold ; Value > Threshold).

metric_status(Metric, Value, warning) :-
    warning_threshold(Metric, Threshold),
    \+ metric_status(Metric, Value, critical),
    (Metric = data_quality_score -> Value < Threshold ; Value > Threshold).

metric_status(Metric, Value, normal) :-
    \+ metric_status(Metric, Value, critical),
    \+ metric_status(Metric, Value, warning).

% ============================================================================
% MOTEUR D'INFÉRENCE - DIAGNOSTIC
% ============================================================================

% Diagnostic principal
run_diagnosis :-
    write('═══════════════════════════════════════════════════════════════'), nl,
    write('    SYSTÈME EXPERT - DIAGNOSTIC DE PIPELINE DE DONNÉES'), nl,
    write('═══════════════════════════════════════════════════════════════'), nl, nl,
    collect_symptoms,
    nl,
    write('═══════════════════════════════════════════════════════════════'), nl,
    write('                    ANALYSE EN COURS...'), nl,
    write('═══════════════════════════════════════════════════════════════'), nl, nl,
    findall(Problem, diagnose(Problem), Problems),
    (Problems = [] ->
        write('✓ Aucun problème détecté avec les symptômes fournis.'), nl,
        nl,
        write('Suggestions d\'optimisation préventive :'), nl,
        suggest_optimizations
    ;
        write('⚠ PROBLÈMES DÉTECTÉS :'), nl, nl,
        display_problems(Problems),
        nl,
        write('═══════════════════════════════════════════════════════════════'), nl,
        write('                    SOLUTIONS RECOMMANDÉES'), nl,
        write('═══════════════════════════════════════════════════════════════'), nl, nl,
        display_solutions(Problems)
    ),
    nl,
    write('═══════════════════════════════════════════════════════════════'), nl.

% Collecte des symptômes
collect_symptoms :-
    write('Veuillez répondre aux questions suivantes (oui/non) :'), nl, nl,
    ask_symptom('Le pipeline échoue soudainement', pipeline_fails_suddenly),
    ask_symptom('Erreur "colonne introuvable"', column_not_found_error),
    ask_symptom('Inadéquation de type de données', data_type_mismatch),
    ask_symptom('Erreur de parsing', parsing_error),
    ask_symptom('Valeurs NULL inattendues', unexpected_null_values),
    ask_symptom('Colonnes manquantes', missing_columns),
    ask_symptom('Exécution lente', slow_execution),
    ask_symptom('Temps de traitement élevé', high_processing_time),
    ask_symptom('Traitement séquentiel', sequential_processing),
    ask_symptom('Lectures intermédiaires multiples', multiple_intermediate_reads),
    ask_symptom('Requêtes inefficaces', inefficient_queries),
    ask_symptom('I/O disque intense', disk_io_heavy),
    ask_symptom('Valeurs incorrectes', incorrect_values),
    ask_symptom('Échec de validation des données', data_validation_fails),
    ask_symptom('Formats incohérents', inconsistent_formats),
    ask_symptom('Corruption de données', data_corruption),
    ask_symptom('Valeurs aberrantes', outlier_values),
    ask_symptom('Anomalies statistiques', statistical_anomalies),
    ask_symptom('Erreur de mémoire insuffisante', out_of_memory_error),
    ask_symptom('Le pipeline plante', pipeline_crashes),
    ask_symptom('Utilisation CPU élevée', high_cpu_usage),
    ask_symptom('Espace disque plein', disk_space_full),
    ask_symptom('Impossible d\'écrire la sortie', cannot_write_output),
    ask_symptom('Pool de connexions épuisé', connection_pool_exhausted),
    ask_symptom('Erreurs de timeout', timeout_errors),
    ask_symptom('Tâche échoue de façon répétée', task_fails_repeatedly),
    ask_symptom('Erreurs dans les logs', error_in_logs),
    ask_symptom('Dépendance non satisfaite', dependency_not_met),
    ask_symptom('En attente de runner', waiting_for_runner),
    ask_symptom('Exception de code', code_exception),
    ask_symptom('Erreur non gérée', unhandled_error),
    ask_symptom('Timeout de connexion', connection_timeout),
    ask_symptom('Échecs intermittents', intermittent_failures),
    ask_symptom('API injoignable', api_unreachable),
    ask_symptom('Codes d\'erreur HTTP', http_error_codes),
    ask_symptom('Accès refusé', access_denied),
    ask_symptom('Échec d\'authentification', authentication_failed),
    ask_symptom('Impossible de lire la source', cannot_read_source),
    ask_symptom('Erreur de permission refusée', permission_denied_error),
    ask_symptom('Enregistrements répétés', repeated_records),
    ask_symptom('Clés dupliquées', duplicate_keys),
    ask_symptom('Nombre d\'enregistrements gonflé', inflated_record_count),
    ask_symptom('Traitement du même batch deux fois', processing_same_batch_twice),
    ask_symptom('Ensemble de résultats vide', empty_result_set),
    ask_symptom('Source indisponible', source_unavailable),
    ask_symptom('Données incomplètes', incomplete_data),
    ask_symptom('Le partenaire a manqué la livraison', partner_missed_delivery),
    ask_symptom('Calcul incorrect', calculation_incorrect),
    ask_symptom('L\'agrégation échoue', aggregation_fails),
    ask_symptom('La jointure produit de mauvais résultats', join_produces_wrong_results),
    ask_symptom('Inadéquation de clés', key_mismatch),
    ask_symptom('Timeout réseau', network_timeout),
    nl,
    collect_characteristics.

% Collecte des caractéristiques du pipeline
collect_characteristics :-
    write('═══════════════════════════════════════════════════════════════'), nl,
    write('        CARACTÉRISTIQUES DU PIPELINE'), nl,
    write('═══════════════════════════════════════════════════════════════'), nl, nl,
    ask_characteristic('Récemment modifié', recently_changed),
    ask_characteristic('Source mise à jour', source_updated),
    ask_characteristic('Fonctionnait auparavant', working_previously),
    ask_characteristic('Volume de données élevé', data_volume, high, low),
    ask_characteristic('Peut être parallélisé', parallelizable),
    ask_characteristic('Architecture monolithique', architecture, monolithic, distributed),
    ask_characteristic('Traitement en mémoire possible', in_memory_possible),
    ask_characteristic('Validation activée', validation_enabled),
    ask_characteristic('Fiabilité de la source faible', source_reliability, low, high),
    ask_characteristic('Monitoring activé', monitoring_enabled),
    ask_characteristic('Intensif en mémoire', memory_intensive),
    ask_characteristic('Niveau d\'optimisation faible', optimization_level, low, high),
    ask_characteristic('Pas de politique de nettoyage', cleanup_policy, none, configured),
    ask_characteristic('Connexions concurrentes élevées', concurrent_connections, high, low),
    ask_characteristic('Pas de mécanisme de retry', retry_mechanism, no, yes),
    ask_characteristic('Orchestration mal configurée', orchestration, misconfigured, configured),
    ask_characteristic('Gestion d\'erreur inadéquate', error_handling, inadequate, adequate),
    ask_characteristic('Dépend du réseau', network_dependent),
    ask_characteristic('Source externe', external_source),
    ask_characteristic('Credentials récemment mises à jour', credentials_updated, recently, long_ago),
    ask_characteristic('Politique de sécurité stricte', security_policy, strict, relaxed),
    ask_characteristic('Déduplication désactivée', deduplication, disabled, enabled),
    ask_characteristic('Pas d\'idempotence', idempotency, no, yes),
    ask_characteristic('Pas de vérification de dépendances', dependency_check, no, yes),
    ask_characteristic('Dépendance externe', external_dependency),
    ask_characteristic('Logique complexe', logic_complex),
    ask_characteristic('Modèle de données peu clair', data_model, unclear, clear).

% Poser une question sur un symptôme
ask_symptom(Question, Symptom) :-
    format('~w ? (oui/non): ', [Question]),
    read(Response),
    (Response = oui ->
        assertz(symptom(Symptom))
    ;
        true
    ).

% Poser une question sur une caractéristique binaire
ask_characteristic(Question, Characteristic) :-
    format('~w ? (oui/non): ', [Question]),
    read(Response),
    (Response = oui ->
        assertz(pipeline_characteristic(Characteristic, yes))
    ;
        assertz(pipeline_characteristic(Characteristic, no))
    ).

% Poser une question sur une caractéristique avec valeurs
ask_characteristic(Question, Characteristic, YesValue, NoValue) :-
    format('~w ? (oui/non): ', [Question]),
    read(Response),
    (Response = oui ->
        assertz(pipeline_characteristic(Characteristic, YesValue))
    ;
        assertz(pipeline_characteristic(Characteristic, NoValue))
    ).

% Afficher les problèmes détectés
display_problems([]).
display_problems([Problem|Rest]) :-
    problem_description(Problem, Description),
    format('   • ~w: ~w~n', [Problem, Description]),
    display_problems(Rest).

% Afficher les solutions pour tous les problèmes
display_solutions([]).
display_solutions([Problem|Rest]) :-
    format('~n▶ Solutions pour ~w :~n~n', [Problem]),
    findall(
        [Action, Details, Priority],
        solution(Problem, Action, Details, Priority),
        Solutions
    ),
    display_solution_list(Solutions, 1),
    display_solutions(Rest).

% Afficher une liste de solutions
display_solution_list([], _).
display_solution_list([[Action, Details, Priority]|Rest], N) :-
    priority_symbol(Priority, Symbol),
    format('   ~w. [~w] ~w~n', [N, Symbol, Action]),
    format('      → ~w~n~n', [Details]),
    N1 is N + 1,
    display_solution_list(Rest, N1).

% Symboles de priorité
priority_symbol(high, '!!!').
priority_symbol(medium, '!! ').
priority_symbol(low, '!  ').

% Suggérer des optimisations préventives
suggest_optimizations :-
    findall(Opt, optimization_recommendation(Opt), Optimizations),
    (Optimizations = [] ->
        write('  Aucune optimisation particulière recommandée.'), nl
    ;
        write('  OPTIMISATIONS RECOMMANDÉES :'), nl, nl,
        display_optimization_list(Optimizations)
    ).

% Afficher les optimisations
display_optimization_list([]).
display_optimization_list([Opt|Rest]) :-
    optimization_description(Opt, Title, Description, Tools),
    format('   • ~w~n', [Title]),
    format('     Description: ~w~n', [Description]),
    format('     Outils suggérés: ~w~n~n', [Tools]),
    display_optimization_list(Rest).

% ============================================================================
% ANALYSE DE MÉTRIQUES
% ============================================================================

analyze_metrics :-
    write('═══════════════════════════════════════════════════════════════'), nl,
    write('              ANALYSE DES MÉTRIQUES'), nl,
    write('═══════════════════════════════════════════════════════════════'), nl, nl,
    write('Entrez les valeurs des métriques (ou 0 pour ignorer) :'), nl, nl,
    read_metric(execution_time, 'Temps d\'exécution (secondes)'),
    read_metric(error_rate, 'Taux d\'erreur (%)'),
    read_metric(resource_utilization, 'Utilisation des ressources (%)'),
    read_metric(data_quality_score, 'Score de qualité des données (%)'),
    nl,
    write('═══════════════════════════════════════════════════════════════'), nl,
    write('              RÉSULTATS DE L\'ANALYSE'), nl,
    write('═══════════════════════════════════════════════════════════════'), nl, nl,
    evaluate_all_metrics.

% Lire une métrique
read_metric(Metric, Label) :-
    format('~w: ', [Label]),
    read(Value),
    (Value > 0 ->
        assertz(user_response(Metric, Value))
    ;
        true
    ).

% Évaluer toutes les métriques
evaluate_all_metrics :-
    findall([Metric, Value], user_response(Metric, Value), Metrics),
    evaluate_metric_list(Metrics).

evaluate_metric_list([]).
evaluate_metric_list([[Metric, Value]|Rest]) :-
    metric_status(Metric, Value, Status),
    status_symbol(Status, Symbol),
    format('~w ~w: ~w ', [Symbol, Metric, Value]),
    metric(Metric, Unit),
    format('~w - ', [Unit]),
    status_message(Status, Message),
    format('~w~n', [Message]),
    (Status \= normal ->
        suggest_metric_solution(Metric, Status)
    ;
        true
    ),
    nl,
    evaluate_metric_list(Rest).

% Symboles de statut
status_symbol(critical, '⚠⚠⚠').
status_symbol(warning, '⚠  ').
status_symbol(normal, '✓  ').

% Messages de statut
status_message(critical, 'CRITIQUE - Action immédiate requise').
status_message(warning, 'ATTENTION - Surveillance recommandée').
status_message(normal, 'NORMAL - Dans les limites acceptables').

% Suggestions basées sur les métriques
suggest_metric_solution(execution_time, critical) :-
    write('   → Implémenter le traitement parallèle'), nl,
    write('   → Optimiser les requêtes de base de données'), nl,
    write('   → Considérer le scaling horizontal'), nl.

suggest_metric_solution(execution_time, warning) :-
    write('   → Analyser les goulots d\'étranglement'), nl,
    write('   → Optimiser les transformations coûteuses'), nl.

suggest_metric_solution(error_rate, critical) :-
    write('   → Analyser les logs d\'erreur immédiatement'), nl,
    write('   → Implémenter des retry mechanisms robustes'), nl,
    write('   → Améliorer la validation des données'), nl.

suggest_metric_solution(error_rate, warning) :-
    write('   → Monitorer les patterns d\'erreur'), nl,
    write('   → Renforcer les tests unitaires'), nl.

suggest_metric_solution(resource_utilization, critical) :-
    write('   → Augmenter les ressources immédiatement'), nl,
    write('   → Implémenter l\'auto-scaling'), nl,
    write('   → Optimiser l\'utilisation mémoire'), nl.

suggest_metric_solution(resource_utilization, warning) :-
    write('   → Planifier l\'augmentation des ressources'), nl,
    write('   → Optimiser le code pour réduire la charge'), nl.

suggest_metric_solution(data_quality_score, critical) :-
    write('   → Arrêter le pipeline et investiguer'), nl,
    write('   → Implémenter des validations strictes'), nl,
    write('   → Vérifier les sources de données'), nl.

suggest_metric_solution(data_quality_score, warning) :-
    write('   → Renforcer les règles de validation'), nl,
    write('   → Ajouter des alertes de qualité'), nl.

% ============================================================================
% INTERFACE PRINCIPALE
% ============================================================================

start :-
    write(' '), nl,
    write('╔═══════════════════════════════════════════════════════════════╗'), nl,
    write('║                                                               ║'), nl,
    write('║     SYSTÈME EXPERT : PIPELINES DE DONNÉES                    ║'), nl,
    write('║     Diagnostic et Optimisation                               ║'), nl,
    write('║                                                               ║'), nl,
    write('║     Auteur: Maryem EL YAZGHI                                 ║'), nl,
    write('║     ENSA Tanger - GINF3                                      ║'), nl,
    write('║                                                               ║'), nl,
    write('╚═══════════════════════════════════════════════════════════════╝'), nl,
    nl,
    write('Choisissez une option :'), nl,
    write('  1. Diagnostic de problèmes'), nl,
    write('  2. Analyse de métriques'), nl,
    write('  3. Quitter'), nl, nl,
    write('Votre choix (1/2/3): '),
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :-
    retractall(symptom(_)),
    retractall(pipeline_characteristic(_, _)),
    retractall(user_response(_, _)),
    nl,
    run_diagnosis,
    nl,
    write('Appuyez sur Entrée pour continuer...'), nl,
    get_char(_),
    start.

handle_choice(2) :-
    retractall(user_response(_, _)),
    nl,
    analyze_metrics,
    nl,
    write('Appuyez sur Entrée pour continuer...'), nl,
    get_char(_),
    start.

handle_choice(3) :-
    nl,
    write('Merci d\'avoir utilisé le système expert !'), nl,
    write('Au revoir.'), nl, nl.

handle_choice(_) :-
    nl,
    write('Choix invalide. Veuillez réessayer.'), nl, nl,
    start.

% Point d'entrée principal
:- initialization(start).
