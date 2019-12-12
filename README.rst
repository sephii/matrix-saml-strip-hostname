=============================
Matrix SAML hostname stripper
=============================

This mapping provider strips the ``@domain.com`` part from UIDs coming from a SAML2
identity provider (IDP). This is useful for example when `using Google Apps as
an IDP <https://support.google.com/a/answer/6087519?hl=en>`_, to avoid getting
Matrix IDs like ``jane.doe=40domain.com@domain.com`` (instead you'll get
``jane.doe@domain.com``).

**Note:** At the time of this writing, the `support for user-configurable
mapping providers <https://github.com/matrix-org/synapse/pull/6411>`_ hasn't
been released yet. You will probably have to wait for Synapse 1.7 or 1.8, or
install an unreleased version of Synapse.

------------
Installation
------------

Run the following command in the same virtual environment of your Synapse install:

``pip install matrix-saml-strip-hostname``

Then edit the ``homeserver.yaml`` file on your Synapse install to use the new
mapping provider::

  saml2_config:
    user_mapping_provider:
      module: matrix_saml_strip_hostname.mapping_providers.StripHostnameSamlMappingProvider

-------------
Configuration
-------------

This mapper inherits from `the default mapping provider
<https://github.com/matrix-org/synapse/blob/fc316a4894912f49f5d0321e533aabca5624b0ba/docs/saml_mapping_providers.md#synapses-default-provider>`_.
It will first strip the hostname, and then pass the result to the
``synapse.handlers.saml_handler.DefaultSamlMappingProvider`` mapping provider.
There is no support for disabling this post-processing.

Refer to `the default configuration file
<https://github.com/matrix-org/synapse/blob/fc316a4894912f49f5d0321e533aabca5624b0ba/docs/sample_config.yaml#L1272>`_
for configuration options for the default provider.
