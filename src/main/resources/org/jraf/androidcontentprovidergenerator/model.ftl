<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Data model for the {@code ${entity.nameLowerCase}} table.
</#if>
 * @see ${entity.nameCamelCase}Impl
 * @see ${entity.nameCamelCase}Key
 * @see ${entity.nameCamelCase}Value
 */
public interface ${entity.nameCamelCase}Model extends ${entity.nameCamelCase}Key, ${entity.nameCamelCase}Value {
}
