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
 * Immutable implementation of {@link ${entity.nameCamelCase}Model}
</#if>
 *
 * @see ${entity.nameCamelCase}Impl.Builder
 */
public class ${entity.nameCamelCase}Impl implements ${entity.nameCamelCase}Model {
    public static class Builder implements ${entity.nameCamelCase}Model {
    <#list entity.getFields() as field>
        private ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>; 
    </#list>

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link ${entity.nameCamelCase}Model}
         */
        public Builder(${entity.nameCamelCase}Model copy) {
    <#list entity.getFields() as field>
            this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = copy.get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}();
    </#list>
        }
    <#list entity.getFields() as field>

	    <#if config.useAnnotations && !field.isNullable && !field.type.hasNotNullableJavaType()>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(@NonNull ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
	    <#elseif config.useAnnotations && field.isNullable>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(@Nullable ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
	    <#else>
        public Builder set<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}(${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) {
	    </#if>
            this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
            return this;
        }

     <#if config.useAnnotations>
        <#if field.isNullable>
        @Nullable
        <#else>
            <#if !field.type.hasNotNullableJavaType()>
        @NonNull
            </#if>
        </#if>
     </#if>
        @Override
        public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
            return <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
        }
    </#list>
    
        public ${entity.nameCamelCase}Impl build() {
        <#list entity.getKeys() as field>
            <#switch field.type.name()>
            <#case "STRING">
            <#case "ENUM">
            <#case "DATE">
            if (null == <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>) throw new IllegalStateException("<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> is a key and cannot be null");
            <#break>
            <#default>
            </#switch>
        </#list>
            return new ${entity.nameCamelCase}Impl(this);
        }
    }

    <#list entity.getFields() as field>
    private final ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>; 
    </#list>

    private ${entity.nameCamelCase}Impl(${entity.nameCamelCase}Model model) {
    <#list entity.getFields() as field>
        this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = model.get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}();
    </#list>
    }
    <#list entity.getFields() as field>

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
    @Override
    public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
        return <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
    }
    </#list>
}
