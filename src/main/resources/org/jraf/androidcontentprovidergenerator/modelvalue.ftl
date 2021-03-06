<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import java.util.Date;
<#if config.useAnnotations>

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
</#if>

/**
<#if entity.documentation??>
 * ${entity.documentation}
<#else>
 * Data model for the {@code ${entity.nameLowerCase}} table.
</#if>
 * @see ${entity.nameCamelCase}Model
 * @see ${entity.nameCamelCase}Impl
 */
public interface ${entity.nameCamelCase}Value {
    <#list entity.getFields() as field>
        <#if !field.isId && !field.isKey>

    /**
    <#if field.documentation??>
     * ${field.documentation}
    <#else>
     * Get the {@code ${field.nameLowerCase}} value.
    </#if>
        <#if field.isNullable>
     * Can be {@code null}.
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
     * Cannot be {@code null}.
            </#if>
        </#if>
     */
     <#if config.useAnnotations>
        <#if field.isNullable>
    @Nullable
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
    @NonNull
            </#if>
        </#if>
     </#if>
    ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}();
        </#if>
    </#list>
}
