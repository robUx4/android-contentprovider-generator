<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import com.levelup.palabre.provider.base.DatabaseSerializer;

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Serializer interface for the {@code ${entity.nameLowerCase}} table.
</#if>
 */
public interface ${entity.nameCamelCase}Serializer extends DatabaseSerializer<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor> {
}