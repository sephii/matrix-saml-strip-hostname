from synapse.handlers.saml import DefaultSamlMappingProvider, SamlConfig
from synapse.module_api import ModuleApi


def strip_domain(username: str) -> str:
    at_position = username.rfind("@")
    return username[:at_position] if at_position > -1 else username


class StripHostnameSamlMappingProvider(DefaultSamlMappingProvider):
    def __init__(self, parsed_config: SamlConfig, module_api: ModuleApi):
        super().__init__(parsed_config, module_api)

        orig_mxid_mapper = self._mxid_mapper
        self._mxid_mapper = lambda username: orig_mxid_mapper(
            strip_domain(username)
        )
