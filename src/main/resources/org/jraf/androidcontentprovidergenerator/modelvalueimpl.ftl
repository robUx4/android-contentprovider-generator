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
 * Immutable implementation of {@link ${entity.nameCamelCase}Value}
</#if>
 *
 * @see ${entity.nameCamelCase}ValueImpl.Builder
 */
public class ${entity.nameCamelCase}ValueImpl implements ${entity.nameCamelCase}Value {
    public static class Builder implements ${entity.nameCamelCase}Value {
    <#list entity.getFields() as field>
        <#if !field.isId && !field.isKey>
        private ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
        </#if> 
    </#list>

        public Builder() {
        }

        /**
         * Construct a copy of the specified {@link ${entity.nameCamelCase}Value}
         */
        public Builder(${entity.nameCamelCase}Value copy) {
    <#list entity.getFields() as field>
        <#if !field.isId && !field.isKey>
            this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = copy.get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}();
        </#if>
    </#list>
        }
    <#list entity.getFields() as field>
      <#if !field.isId && !field.isKey>

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
      </#if>
    </#list>

        public ${entity.nameCamelCase}ValueImpl build() {
            return new ${entity.nameCamelCase}ValueImpl(this);
        }
    }

    <#list entity.getFields() as field>
      <#if !field.isId && !field.isKey>
    private final ${field.javaTypeSimpleName} <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
      </#if> 
    </#list>

    protected ${entity.nameCamelCase}ValueImpl(Builder builder) {
    <#list entity.getFields() as field>
      <#if !field.isId && !field.isKey>
        this.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if> = builder.<#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
      </#if>
    </#list>
    }
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
    @Override
    public ${field.javaTypeSimpleName} get<#if field.isForeign>${field.path}</#if>${field.nameCamelCase}() {
        return <#if field.isForeign>${field.path?uncap_first}${field.nameCamelCase}<#else>${field.nameCamelCaseLowerCase}</#if>;
    }
    </#if>
    </#list>
}
