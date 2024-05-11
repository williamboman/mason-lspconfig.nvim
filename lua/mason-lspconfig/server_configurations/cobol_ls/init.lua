return function()
    -- https://github.com/eclipse-che4z/che-che4z-lsp-for-cobol/blob/59132a8d04349720a0ba0f87f5fb757d9d5e79a3/clients/cobol-lsp-vscode-extension/src/services/nativeLanguageClient/linuxlanguageClient.ts#L30-L35
    return {
        cmd = {
            "cobol-language-support",
            "pipeEnabled",
            "-Dline.separator=\r\n",
            "-Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener",
            "-DserverType=NATIVE",
        },
    }
end
